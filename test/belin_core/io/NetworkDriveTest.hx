package belin_core.io;

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
	#end

	/** Tests the `resolve()` method. **/
	@:variant("\\\\localhost\\share\\folder\\file.txt", "Z:\\folder\\file.txt")
	@:variant("//localhost/share/folder/file.txt", "Z:\\folder\\file.txt")
	@:variant("/folder/file.txt", "Z:\\folder\\file.txt")
	@:variant("../folder/file.txt", "Z:..\\folder\\file.txt")
	public function resolve(input: String, output: String)
		return assert(new NetworkDrive("Z", "\\\\localhost\\share").resolve(input) == output);
}
