import {execFile} from "node:child_process";
import {access} from "node:fs/promises";
import {join, normalize} from "node:path";
import {env, platform} from "node:process";
import {promisify} from "node:util";

/**
 * Spawns a new process using the specified command.
 */
const run = promisify(execFile);

/**
 * Represents a Windows network drive.
 */
export class NetworkDrive {

	/**
	 * The drive letter.
	 */
	readonly drive: string;

	/**
	 * The underlying UNC path.
	 */
	readonly uncPath: string;

	/**
	 * The password to use for mounting this network drive.
	 */
	readonly #password: string;

	/**
	 * The username to use for mounting this network drive.
	 */
	readonly #user: string;

	/**
	 * Creates a new network drive.
	 * @param drive The drive letter.
	 * @param uncPath The underlying UNC path.
	 * @param user The username to use for mounting this network drive.
	 * @param password The password to use for mounting this network drive.
	 */
	constructor(drive: string, uncPath: string, user = "", password = "") {
		this.drive = drive.toUpperCase();
		this.uncPath = this.#normalizeUncPath(uncPath);
		this.#password = password;
		this.#user = user;
	}

	/**
	 * Value indicating whether this network drive is mounted.
	 */
	get isMounted(): Promise<boolean> {
		return access(`${this.drive}:/`).then(() => true, () => false);
	}

	/**
	 * Creates a new network drive from the specified file URI.
	 * @param uri A file URI representing a UNC path.
	 * @returns The network drive corresponding to the specified file URI.
	 */
	static fromUri(uri: URL): NetworkDrive {
		return new this(
			uri.searchParams.get("drive") ?? "Z",
			`\\\\${uri.hostname ? uri.hostname : "localhost"}\\${decodeURIComponent(uri.pathname).slice(1).split("/").at(0)}`,
			decodeURIComponent(uri.username),
			decodeURIComponent(uri.password)
		);
	}

	/**
	 * Returns the local path corresponding to the specified file URI.
	 * @param uri A file URI representing a local or UNC path.
	 * @param options Values indicating whether to mount the network drive if necessary.
	 * @returns The local path corresponding to the specified file URI.
	 */
	static async resolveUri(uri: URL, options: {mount?: boolean, persistent?: boolean} = {}): Promise<string> {
		const host = uri.hostname ? uri.hostname : "localhost";
		const path = decodeURIComponent(uri.pathname).replace(/\/+$/, "");
		if (uri.protocol == "file:" && host == "localhost") return Promise.resolve(normalize(/^\/[A-Z]:/i.test(path) ? path.slice(1) : path));

		const drive = this.fromUri(uri);
		if (options.mount && !(await drive.isMounted)) await drive.mount(options);
		return drive.resolve(`/${path.slice(1).split("/").slice(1).join("/")}`);
	}

	/**
	 * Mounts this network drive.
	 * @param options Value indicating whether to use a persistent network connection.
	 * @returns Resolves when the command has been completed.
	 */
	async mount(options: {persistent?: boolean} = {}): Promise<void> {
		const credentials = this.#user ? [`/user:${this.#user}`, this.#password] : [];
		const flag = options.persistent ? "yes" : "no";
		await this.#netUse([`${this.drive}:`, this.uncPath, `/persistent:${flag}`, ...credentials]);
	}

	/**
	 * Resolves the specified UNC path into a local path.
	 * @param path The UNC path to resolve.
	 * @returns The resolved local path.
	 */
	resolve(path: string): string {
		path = this.#normalizeUncPath(path);
		if (!path.startsWith("\\\\")) return `${this.drive}:${path}`;
		return path.startsWith(this.uncPath) ? `${this.drive}:${path.slice(this.uncPath.length)}` : path;
	}

	/**
	 * Unmounts this network drive.
	 * @returns Resolves when the command has been completed.
	 */
	async unmount(): Promise<void> {
		await this.#netUse([`${this.drive}:`, "/delete", "/yes"]);
	}

	/**
	 * Runs the `net use` command.
	 * @param args The command arguments.
	 * @returns Resolves when the command has been completed.
	 */
	async #netUse(args: Array<string>): Promise<void> {
		const executable = platform == "win32" ? join(env.windir ?? "C:/Windows", "System32/net.exe") : "net";
		await run(executable, ["use", ...args]);
	}

	/**
	 * Normalizes the specified UNC path.
	 * @param path The UNC path to normalize.
	 * @returns The normalized UNC path.
	 */
	#normalizeUncPath(path: string): string {
		return path.replaceAll("/", "\\").replace(/\\+$/, "");
	}
}
