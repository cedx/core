import {AccessLevel, greaterThan, greaterThanOrEqual, lessThan, lessThanOrEqual} from "@cedx/core/Security/AccessLevel.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link AccessLevel} enumeration.
 */
describe("AccessLevel", () => {
	describe("greaterThan()", () => {
		it("should return `false` if the first access level is less than or equal to the second", () => {
			assert.isFalse(greaterThan(AccessLevel.Read, AccessLevel.Read));
			assert.isFalse(greaterThan(AccessLevel.Read, AccessLevel.Write));
			assert.isFalse(greaterThan(AccessLevel.Read, AccessLevel.Admin));
			assert.isFalse(greaterThan(AccessLevel.Write, AccessLevel.Write));
			assert.isFalse(greaterThan(AccessLevel.Write, AccessLevel.Admin));
			assert.isFalse(greaterThan(AccessLevel.Admin, AccessLevel.Admin));
		});

		it("should return `true` if the first access level is greater than the second", () => {
			assert.isTrue(greaterThan(AccessLevel.Write, AccessLevel.Read));
			assert.isTrue(greaterThan(AccessLevel.Admin, AccessLevel.Read));
			assert.isTrue(greaterThan(AccessLevel.Admin, AccessLevel.Write));
		});
	});

	describe("greaterThanOrEqual()", () => {
		it("should return `false` if the first access level is less than the second", () => {
			assert.isFalse(greaterThanOrEqual(AccessLevel.Read, AccessLevel.Write));
			assert.isFalse(greaterThanOrEqual(AccessLevel.Read, AccessLevel.Admin));
			assert.isFalse(greaterThanOrEqual(AccessLevel.Write, AccessLevel.Admin));
		});

		it("should return `true` if the first access level is greater than or equal to the second", () => {
			assert.isTrue(greaterThanOrEqual(AccessLevel.Read, AccessLevel.Read));
			assert.isTrue(greaterThanOrEqual(AccessLevel.Write, AccessLevel.Read));
			assert.isTrue(greaterThanOrEqual(AccessLevel.Write, AccessLevel.Write));
			assert.isTrue(greaterThanOrEqual(AccessLevel.Admin, AccessLevel.Read));
			assert.isTrue(greaterThanOrEqual(AccessLevel.Admin, AccessLevel.Write));
			assert.isTrue(greaterThanOrEqual(AccessLevel.Admin, AccessLevel.Admin));
		});
	});

	describe("lessThan()", () => {
		it("should return `false` if the first access level is greater than or equal to the second", () => {
			assert.isFalse(lessThan(AccessLevel.Read, AccessLevel.Read));
			assert.isFalse(lessThan(AccessLevel.Write, AccessLevel.Read));
			assert.isFalse(lessThan(AccessLevel.Write, AccessLevel.Write));
			assert.isFalse(lessThan(AccessLevel.Admin, AccessLevel.Read));
			assert.isFalse(lessThan(AccessLevel.Admin, AccessLevel.Write));
			assert.isFalse(lessThan(AccessLevel.Admin, AccessLevel.Admin));
		});

		it("should return `true` if the first access level is less than the second", () => {
			assert.isTrue(lessThan(AccessLevel.Read, AccessLevel.Write));
			assert.isTrue(lessThan(AccessLevel.Read, AccessLevel.Admin));
			assert.isTrue(lessThan(AccessLevel.Write, AccessLevel.Admin));
		});
	});

	describe("lessThanOrEqual()", () => {
		it("should return `false` if the first access level is greater than the second", () => {
			assert.isFalse(lessThanOrEqual(AccessLevel.Write, AccessLevel.Read));
			assert.isFalse(lessThanOrEqual(AccessLevel.Admin, AccessLevel.Read));
			assert.isFalse(lessThanOrEqual(AccessLevel.Admin, AccessLevel.Write));
		});

		it("should return `true` if the first access level is less than or equal to the second", () => {
			assert.isTrue(lessThanOrEqual(AccessLevel.Read, AccessLevel.Read));
			assert.isTrue(lessThanOrEqual(AccessLevel.Read, AccessLevel.Write));
			assert.isTrue(lessThanOrEqual(AccessLevel.Read, AccessLevel.Admin));
			assert.isTrue(lessThanOrEqual(AccessLevel.Write, AccessLevel.Write));
			assert.isTrue(lessThanOrEqual(AccessLevel.Write, AccessLevel.Admin));
			assert.isTrue(lessThanOrEqual(AccessLevel.Admin, AccessLevel.Admin));
		});
	});
});
