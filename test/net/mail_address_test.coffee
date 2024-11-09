import {MailAddress} from "@cedx/core/net/mail_address.js"
import {assert} from "chai"

# Tests the features of the `MailAddress` class.
describe "MailAddress", ->
	{equal, isFalse, isTrue} = assert

	describe "host", ->
		it "should return the portion after the '@' symbol", ->
			equal new MailAddress("Foo.Bar@Domain.TLD").host, "domain.tld"
			equal new MailAddress("teßt@täst.de").host, "täst.de"

	describe "isEmpty", ->
		it "should return `true` if the address is empty", ->
			isTrue new MailAddress("").isEmpty
			isTrue new MailAddress(" \r\n ").isEmpty

		it "should return `false` if the address is not empty", ->
			isFalse new MailAddress("cedric@belin.io").isEmpty

	describe "isValid", ->
		it "should return `false` for an invalid address", ->
			isFalse new MailAddress("").isValid
			isFalse new MailAddress("cedric@").isValid
			isFalse new MailAddress("@belin.io").isValid

		it "should return `true` for a valid address", ->
			isTrue new MailAddress("cedric@belin.io").isValid
			isTrue new MailAddress("foo-bar.baz-qux@foo.bar.baz.qux.tld").isValid

	describe "user", ->
		it "should return the portion before the '@' symbol", ->
			equal new MailAddress("Foo.Bar@Domain.TLD").user, "foo.bar"
			equal new MailAddress("teßt@täst.de").user, "teßt"
