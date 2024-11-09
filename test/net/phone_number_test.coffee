import {PhoneNumber} from "@cedx/core/net/phone_number.js"
import {assert} from "chai"

# Tests the features of the `PhoneNumber` class.
describe "PhoneNumber", ->
	{equal, isFalse, isTrue} = assert

	describe "constructor()", ->
		it "should normalize the given phone number", ->
			equal String(new PhoneNumber("0032 / 467.123.456")), "+32467123456"
			equal String(new PhoneNumber("04-67-12-34-56")), "+33467123456"

	describe "isEmpty", ->
		it "should return `true` if the phone number is empty", ->
			isTrue new PhoneNumber("").isEmpty
			isTrue new PhoneNumber(" \r\n ").isEmpty

		it "should return `false` if the phone number is not empty", ->
			isFalse new PhoneNumber("0467123456").isEmpty

	describe "isValid", ->
		it "should return `false` for an invalid phone number", ->
			isFalse new PhoneNumber("").isValid
			isFalse new PhoneNumber("+33 467 foo 123 bar 456").isValid

		it "should return `true` for a valid phone number", ->
			isTrue new PhoneNumber("+32 / 467.123.456").isValid
			isTrue new PhoneNumber("04-67-12-34-56").isValid

	describe "format()", ->
		it "should format the given phone number according to the locale", ->
			equal new PhoneNumber("0467123456").format(), "04 67 12 34 56"
			equal new PhoneNumber("+32467123456").format(), "+32 4 67 12 34 56"
			equal new PhoneNumber("0032467123456").format(), "+32 4 67 12 34 56"
			equal new PhoneNumber("+33467123456").format(), "04 67 12 34 56"