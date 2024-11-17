/**
 * Represents a Windows network drive.
 */
export class NetworkDrive {

	/**
	 * The drive letter.
	 */
	drive: string;

	/**
	 * Value indicating whether this network drive is mounted.
	 */
	readonly isMounted: Promise<boolean>;

	/**
	 * The underlying UNC path.
	 */
	uncPath: string;

	/**
	 * Creates a new network drive.
	 * @param drive The drive letter.
	 * @param uncPath The underlying UNC path.
	 * @param user The username to use for mounting this network drive.
	 * @param password The password to use for mounting this network drive.
	 */
	constructor(drive: string, uncPath: string, user?: string, password?: string);

	/**
	 * Creates a new network drive from the specified file URI.
	 * @param uri A file URI representing a UNC path.
	 * @returns The network drive corresponding to the specified file URI.
	 */
	static fromUri(uri: URL): NetworkDrive;

	/**
	 * Returns the local path corresponding to the specified file URI.
	 * @param uri A file URI representing a local or UNC path.
	 * @param options Values indicating whether to mount the network drive if necessary.
	 * @returns The local path corresponding to the specified file URI.
	 */
	static resolveUri(uri: URL, options?: {mount?: boolean, persistent?: boolean}): Promise<string>;

	/**
	 * Mounts this network drive.
	 * @param options Value indicating whether to use a persistent network connection.
	 * @returns Resolves when the command has been completed.
	 */
	mount(options?: {persistent?: boolean}): Promise<void>;

	/**
	 * Resolves the specified UNC path into a local path.
	 * @param path The UNC path to resolve.
	 * @returns The resolved local path.
	 */
	resolve(path: string): string;

	/**
	 * Unmounts this network drive.
	 * @returns Resolves when the command has been completed.
	 */
	unmount(): Promise<void>;
}
