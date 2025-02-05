import {round} from "@cedx/core/util/number.js";
import {assert} from "chai";

/**
 * Tests the features of the number utilities.
 */
describe("Number utilities", () => {
	const {equal} = assert;

	describe("round()", () => {
		it("should round the specified value to the given precision", () => {
			equal(round(123.456, 0), 123);
			equal(round(123.456, 1), 123.5);
			equal(round(123.456, 2), 123.46);
		});
	});
});
