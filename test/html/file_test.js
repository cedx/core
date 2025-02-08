import {toDataUrl} from "@cedx/core/html/file.js";
import {assert} from "chai";

/**
 * Tests the features of the file utilities.
 */
describe("File utilities", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("toDataUrl()", () => {
		it("should convert the specified file to a data URL", async () => {
			const file = new File(["Hello World!"], "hello.txt", {type: "text/plain"});
			equal((await toDataUrl(file)).href, "data:text/plain;base64,SGVsbG8gV29ybGQh");
		});
	});
});
