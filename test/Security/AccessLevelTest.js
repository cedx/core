import {AccessLevel, greaterThan, greaterThanOrEqual, lessThan, lessThanOrEqual} from "@cedx/core/Security/AccessLevel.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link AccessLevel} enumeration.
 */
describe("AccessLevel", () => {
	describe("greaterThan()", () => {
		it("should return `false` if the first access level is less than or equal to the second", () => {
			assert.isFalse(greaterThan(AccessLevel.read, AccessLevel.read));
			assert.isFalse(greaterThan(AccessLevel.read, AccessLevel.write));
			assert.isFalse(greaterThan(AccessLevel.read, AccessLevel.admin));
			assert.isFalse(greaterThan(AccessLevel.write, AccessLevel.write));
			assert.isFalse(greaterThan(AccessLevel.write, AccessLevel.admin));
			assert.isFalse(greaterThan(AccessLevel.admin, AccessLevel.admin));
		});

		it("should return `true` if the first access level is greater than the second", () => {
			assert.isTrue(greaterThan(AccessLevel.write, AccessLevel.read));
			assert.isTrue(greaterThan(AccessLevel.admin, AccessLevel.read));
			assert.isTrue(greaterThan(AccessLevel.admin, AccessLevel.write));
		});
	});

	describe("greaterThanOrEqual()", () => {
		it("should return `false` if the first access level is less than the second", () => {
			assert.isFalse(greaterThanOrEqual(AccessLevel.read, AccessLevel.write));
			assert.isFalse(greaterThanOrEqual(AccessLevel.read, AccessLevel.admin));
			assert.isFalse(greaterThanOrEqual(AccessLevel.write, AccessLevel.admin));
		});

		it("should return `true` if the first access level is greater than or equal to the second", () => {
			assert.isTrue(greaterThanOrEqual(AccessLevel.read, AccessLevel.read));
			assert.isTrue(greaterThanOrEqual(AccessLevel.write, AccessLevel.read));
			assert.isTrue(greaterThanOrEqual(AccessLevel.write, AccessLevel.write));
			assert.isTrue(greaterThanOrEqual(AccessLevel.admin, AccessLevel.read));
			assert.isTrue(greaterThanOrEqual(AccessLevel.admin, AccessLevel.write));
			assert.isTrue(greaterThanOrEqual(AccessLevel.admin, AccessLevel.admin));
		});
	});

	describe("lessThan()", () => {
		it("should return `false` if the first access level is greater than or equal to the second", () => {
			assert.isFalse(lessThan(AccessLevel.read, AccessLevel.read));
			assert.isFalse(lessThan(AccessLevel.write, AccessLevel.read));
			assert.isFalse(lessThan(AccessLevel.write, AccessLevel.write));
			assert.isFalse(lessThan(AccessLevel.admin, AccessLevel.read));
			assert.isFalse(lessThan(AccessLevel.admin, AccessLevel.write));
			assert.isFalse(lessThan(AccessLevel.admin, AccessLevel.admin));
		});

		it("should return `true` if the first access level is less than the second", () => {
			assert.isTrue(lessThan(AccessLevel.read, AccessLevel.write));
			assert.isTrue(lessThan(AccessLevel.read, AccessLevel.admin));
			assert.isTrue(lessThan(AccessLevel.write, AccessLevel.admin));
		});
	});

	describe("lessThanOrEqual()", () => {
		it("should return `false` if the first access level is greater than the second", () => {
			assert.isFalse(lessThanOrEqual(AccessLevel.write, AccessLevel.read));
			assert.isFalse(lessThanOrEqual(AccessLevel.admin, AccessLevel.read));
			assert.isFalse(lessThanOrEqual(AccessLevel.admin, AccessLevel.write));
		});

		it("should return `true` if the first access level is less than or equal to the second", () => {
			assert.isTrue(lessThanOrEqual(AccessLevel.read, AccessLevel.read));
			assert.isTrue(lessThanOrEqual(AccessLevel.read, AccessLevel.write));
			assert.isTrue(lessThanOrEqual(AccessLevel.read, AccessLevel.admin));
			assert.isTrue(lessThanOrEqual(AccessLevel.write, AccessLevel.write));
			assert.isTrue(lessThanOrEqual(AccessLevel.write, AccessLevel.admin));
			assert.isTrue(lessThanOrEqual(AccessLevel.admin, AccessLevel.admin));
		});
	});
});
