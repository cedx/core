import {isIdentifier, round} from "@cedx/core/util/number.js"
import {assert} from "chai"

# Tests the features of the number utilities.
describe "Number utilities", ->
	{equal, isFalse, isTrue} = assert

	describe "isIdentifier()", ->
		it "should return `true` if the specified number is a numeric identifier", ->
			isTrue isIdentifier 1
			isTrue isIdentifier 999

		it "should return `false` if the specified number isn't a numeric identifier", ->
			isFalse isIdentifier 0
			isFalse isIdentifier -1

	describe "round()", ->
		it "should round the specified value to the given precision", ->
			equal round(123.456, 0), 123
			equal round(123.456, 1), 123.5
			equal round(123.456, 2), 123.46
