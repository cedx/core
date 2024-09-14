package belin_core.io;

using StringTools;

/** Tests the features of the `NetworkDrive` class. **/
@:asserts final class NetworkDriveTest {

	/** Creates a new test. **/
	public function new() {}

	#if tink_url
	/** Tests the `fromUri()` method. **/
	@:variant("smb://localhost/folder", "Z", "\\\\localhost\\folder", "", "")
	@:variant("smb://foo:bar@192.168.100.1/dir/file.txt?drive=D", "D", "\\\\192.168.100.1\\dir", "foo", "bar")
	public function fromUri(input: String, drive: String, uncPath: String, user: String, password: String) {
		final networkDrive = NetworkDrive.fromUri(input);
		asserts.assert(networkDrive.drive == drive);
		asserts.assert(networkDrive.uncPath == uncPath);
		asserts.assert(@:privateAccess networkDrive.user == user);
		asserts.assert(@:privateAccess networkDrive.password == password);
		return asserts.done();
	}

	/** Tests the `resolveUri()` method. **/
	@:variant("file:///C:/path/to/folder/", "C:/path/to/folder")
	@:variant("file://localhost/D:/path/to/folder/", "D:/path/to/folder")
	@:variant("smb://server/share/path/to/folder/", "Z:\\path\\to\\folder")
	@:variant("smb://server/share/path/to/folder/?drive=E", "E:\\path\\to\\folder")
	public function resolveUri(input: String, output: String) {
		NetworkDrive.resolveUri(input)
			.next(localPath -> localPath == output.replace("/", Sys.systemName() == "Windows" ? "\\" : "/"))
			.handle(asserts.handle);

		return asserts;
	}
	#end

	/** Tests the `resolve()` method. **/
	@:variant("\\\\localhost\\share\\folder\\file.txt", "Z:\\folder\\file.txt")
	@:variant("//localhost/share/folder/file.txt", "Z:\\folder\\file.txt")
	@:variant("/folder/file.txt", "Z:\\folder\\file.txt")
	@:variant("../folder/file.txt", "Z:..\\folder\\file.txt")
	public function resolve(input: String, output: String)
		return assert(new NetworkDrive("Z", "\\\\localhost\\share").resolve(input) == output);
}
