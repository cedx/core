import {AccessLevel, greaterThan, greaterThanOrEqual, lessThan, lessThanOrEqual} from "@cedx/core/security/access_level.js"
import {assert} from "chai"

# Tests the features of the `AccessLevel` enumeration.
describe "AccessLevel", ->
	{isFalse, isTrue} = assert

	describe "greaterThan()", ->
		it "should return `false` if the first access level is less than or equal to the second", ->
			isFalse greaterThan AccessLevel.read, AccessLevel.read
			isFalse greaterThan AccessLevel.read, AccessLevel.write
			isFalse greaterThan AccessLevel.read, AccessLevel.admin
			isFalse greaterThan AccessLevel.write, AccessLevel.write
			isFalse greaterThan AccessLevel.write, AccessLevel.admin
			isFalse greaterThan AccessLevel.admin, AccessLevel.admin

		it "should return `true` if the first access level is greater than the second", ->
			isTrue greaterThan AccessLevel.write, AccessLevel.read
			isTrue greaterThan AccessLevel.admin, AccessLevel.read
			isTrue greaterThan AccessLevel.admin, AccessLevel.write

	describe "greaterThanOrEqual()", ->
		it "should return `false` if the first access level is less than the second", ->
			isFalse greaterThanOrEqual AccessLevel.read, AccessLevel.write
			isFalse greaterThanOrEqual AccessLevel.read, AccessLevel.admin
			isFalse greaterThanOrEqual AccessLevel.write, AccessLevel.admin

		it "should return `true` if the first access level is greater than or equal to the second", ->
			isTrue greaterThanOrEqual AccessLevel.read, AccessLevel.read
			isTrue greaterThanOrEqual AccessLevel.write, AccessLevel.read
			isTrue greaterThanOrEqual AccessLevel.write, AccessLevel.write
			isTrue greaterThanOrEqual AccessLevel.admin, AccessLevel.read
			isTrue greaterThanOrEqual AccessLevel.admin, AccessLevel.write
			isTrue greaterThanOrEqual AccessLevel.admin, AccessLevel.admin

	describe "lessThan()", ->
		it "should return `false` if the first access level is greater than or equal to the second", ->
			isFalse lessThan AccessLevel.read, AccessLevel.read
			isFalse lessThan AccessLevel.write, AccessLevel.read
			isFalse lessThan AccessLevel.write, AccessLevel.write
			isFalse lessThan AccessLevel.admin, AccessLevel.read
			isFalse lessThan AccessLevel.admin, AccessLevel.write
			isFalse lessThan AccessLevel.admin, AccessLevel.admin

		it "should return `true` if the first access level is less than the second", ->
			isTrue lessThan AccessLevel.read, AccessLevel.write
			isTrue lessThan AccessLevel.read, AccessLevel.admin
			isTrue lessThan AccessLevel.write, AccessLevel.admin

	describe "lessThanOrEqual()", ->
		it "should return `false` if the first access level is greater than the second", ->
			isFalse lessThanOrEqual AccessLevel.write, AccessLevel.read
			isFalse lessThanOrEqual AccessLevel.admin, AccessLevel.read
			isFalse lessThanOrEqual AccessLevel.admin, AccessLevel.write

		it "should return `true` if the first access level is less than or equal to the second", ->
			isTrue lessThanOrEqual AccessLevel.read, AccessLevel.read
			isTrue lessThanOrEqual AccessLevel.read, AccessLevel.write
			isTrue lessThanOrEqual AccessLevel.read, AccessLevel.admin
			isTrue lessThanOrEqual AccessLevel.write, AccessLevel.write
			isTrue lessThanOrEqual AccessLevel.write, AccessLevel.admin
			isTrue lessThanOrEqual AccessLevel.admin, AccessLevel.admin
