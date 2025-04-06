import {PhoneNumber} from "@cedx/core/Net/PhoneNumber.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link PhoneNumber} class.
 */
describe("PhoneNumber", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("constructor()", () => {
		it("should normalize the given phone number", () => {
			equal(String(new PhoneNumber("0032 / 467.123.456")), "+32467123456");
			equal(String(new PhoneNumber("04-67-12-34-56")), "+33467123456");
		});
	});

	describe("isEmpty", () => {
		it("should return `true` if the phone number is empty", () => {
			assert.isTrue(new PhoneNumber("").isEmpty);
			assert.isTrue(new PhoneNumber(" \r\n ").isEmpty);
		});

		it("should return `false` if the phone number is not empty", () => {
			assert.isFalse(new PhoneNumber("0467123456").isEmpty);
		});
	});

	describe("isValid", () => {
		it("should return `false` for an invalid phone number", () => {
			assert.isFalse(new PhoneNumber("").isValid);
			assert.isFalse(new PhoneNumber("+33 467 foo 123 bar 456").isValid);
		});

		it("should return `true` for a valid phone number", () => {
			assert.isTrue(new PhoneNumber("+32 / 467.123.456").isValid);
			assert.isTrue(new PhoneNumber("04-67-12-34-56").isValid);
		});
	});

	describe("format()", () => {
		it("should format the given phone number according to the locale", () => {
			equal(new PhoneNumber("0467123456").format(), "04 67 12 34 56");
			equal(new PhoneNumber("+32467123456").format(), "+32 4 67 12 34 56");
			equal(new PhoneNumber("0032467123456").format(), "+32 4 67 12 34 56");
			equal(new PhoneNumber("+33467123456").format(), "04 67 12 34 56");
		});
	});
});
