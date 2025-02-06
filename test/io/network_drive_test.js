import {NetworkDrive} from "@cedx/core/io/network_drive.js";
import {assert} from "chai";
import {sep} from "node:path";

/**
 * Tests the features of the {@link NetworkDrive} class.
 */
describe("NetworkDrive", () => {
	describe("fromUri()", () => {
		it("should parse the specified file URI", () => {
			let networkDrive = NetworkDrive.fromUri(new URL("smb://localhost/folder"));
			equal(networkDrive.drive, "Z");
			equal(networkDrive.uncPath, "\\\\localhost\\folder");

			networkDrive = NetworkDrive.fromUri(new URL("smb://foo:bar@192.168.100.1/dir/file.txt?drive=D"));
			equal(networkDrive.drive, "D");
			equal(networkDrive.uncPath, "\\\\192.168.100.1\\dir");
		});
	});

	describe("resolve()", () => {
		it("should resolve an UNC path into a local path", () => {
			const networkDrive = new NetworkDrive("Z", "\\\\localhost\\share");
			equal(networkDrive.resolve("\\\\localhost\\share\\folder\\file.txt"), "Z:\\folder\\file.txt");
			equal(networkDrive.resolve("//localhost/share/folder/file.txt"), "Z:\\folder\\file.txt");
			equal(networkDrive.resolve("/folder/file.txt"), "Z:\\folder\\file.txt");
			equal(networkDrive.resolve("../folder/file.txt"), "Z:..\\folder\\file.txt");
		});
	});

	describe("resolveUri()", () => {
		it("should return the path as is for a local path", async () => {
			equal(await NetworkDrive.resolveUri(new URL("file:///C:/path/to/folder/")), "C:/path/to/folder".replaceAll("/", sep));
			equal(await NetworkDrive.resolveUri(new URL("file://localhost/D:/path/to/folder/")), "D:/path/to/folder".replaceAll("/", sep));
		});

		it("should return a mapped path for a UNC path", async () => {
			equal(await NetworkDrive.resolveUri(new URL("smb://server/share/path/to/folder/")), "Z:\\path\\to\\folder");
			equal(await NetworkDrive.resolveUri(new URL("smb://server/share/path/to/folder/?drive=E")), "E:\\path\\to\\folder");
		});
	});
});
