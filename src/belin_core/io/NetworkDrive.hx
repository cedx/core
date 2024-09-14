package belin_core.io;

#if asys
import asys.FileSystem;
import asys.io.Process;
using StringTools;
using haxe.io.Path;

#if tink_url
import tink.Url;
#end

/** Represents a Windows network drive. **/
final class NetworkDrive {

	/** The drive letter. **/
	public final drive: String;

	/** Value indicating whether this network drive is mounted.**/
	public var isMounted(get, never): Future<Bool>;
		inline function get_isMounted() return FileSystem.exists('$drive:\\');

	/** The underlying UNC path. **/
	public final uncPath: String;

	/** The password to use for mounting this network drive. **/
	final password: String;

	/** The user name to use for mounting this network drive. **/
	final user: String;

	/** Creates a new network drive. **/
	public function new(drive: String, uncPath: String, user = "", password = "") {
		this.drive = drive.toUpperCase();
		this.password = password;
		this.uncPath = normalizePath(uncPath);
		this.user = user;
	}

	#if tink_url
	/** Creates a new network drive from the specified file URI. **/
	public static function fromUri(uri: Url): NetworkDrive {
		final query = uri.query.toMap();
		return new NetworkDrive(
			query.exists("drive") ? query["drive"].toString() : "Z",
			'\\\\${uri.host.name ?? "localhost"}\\${uri.path.parts().shift()}',
			uri.auth != null ? uri.auth.user.urlDecode() : "",
			uri.auth != null ? uri.auth.password.urlDecode() : ""
		);
	}

	/** TODO Returns the local path corresponding to the specified file URI. **/
	public static function resolveUri(uri: Url, ?options: {?mount: Bool, ?persistent: Bool}): Promise<String> {
		final host = uri.host.name ?? "localhost";
		var path = uri.path.removeTrailingSlashes().urlDecode();
		final drive = fromUri(uri);
		return Promise.resolve("TODO");
	}
	#end

	/** Mounts this network drive. **/
	public function mount(persistent = false): Promise<Noise> {
		final flag = persistent ? "yes" : "no";
		return netUse(['$drive:', uncPath, '/persistent:$flag'].concat(user.length > 0 ? ['/user:$user', password] : []));
	}

	/** Resolves the specified UNC path into a local path. **/
	public function resolve(path: String): String {
		path = normalizePath(path);
		return if (!path.startsWith("\\\\")) '$drive:$path' else path.startsWith(uncPath) ? '$drive:${path.substr(uncPath.length)}' : path;
	}

	/** Unmounts this network drive. **/
	public function unmount(): Promise<Noise>
		return netUse(['$drive:', "/delete", "/yes"]);

	/** Runs the `net use` command. **/
	function netUse(arguments: Array<String>): Promise<Noise> {
		final process = new Process(Path.join([Sys.getEnv("windir") ?? "C:/Windows", "System32/net.exe"]), ["use"].concat(arguments));
		return process.exitCode().next(exitCode -> {
			process.close();
			exitCode == 0 ? Noise : Error.withData('The "net use" command failed.', exitCode);
		});
	}

	/** Normalizes the specified UNC path. **/
	function normalizePath(path: String): String
		return path.removeTrailingSlashes().replace("/", "\\");
}
#end
