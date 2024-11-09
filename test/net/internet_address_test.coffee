import {InternetAddress, InternetAddressType} from "@cedx/core/net/internet_address.js"
import {assert} from "chai"

# Tests the features of the `InternetAddress` class.
describe "InternetAddress", ->
	{equal, isFalse, isTrue} = assert

	describe "address", ->
		it "should prefix the address with '::ffff:' for an IPv4", ->
			equal new InternetAddress("192.168.100.1").address, "::ffff:192.168.100.1"

		it "should normalize the address for an IPv6", ->
			equal new InternetAddress("2A01:E0A:59B:1F20:5DD5:62F5:A8A8:1493").address, "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493"
			equal new InternetAddress("[2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493]").address, "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493"

		it "should sanitize the address if it includes a port number", ->
			equal new InternetAddress("192.168.100.1:1234").address, "::ffff:192.168.100.1"
			equal new InternetAddress("[::ffff:192.168.100.1]:1234").address, "::ffff:192.168.100.1"
			equal new InternetAddress("[2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493]:1234").address, "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493"

	describe "isEmpty", ->
		it "should return `true` if the address is empty", ->
			isTrue new InternetAddress("").isEmpty
			isTrue new InternetAddress(" \r\n ").isEmpty

		it "should return `false` if the address is not empty", ->
			isFalse new InternetAddress("::1").isEmpty
			isFalse new InternetAddress("192.168.100.1").isEmpty

	describe "isValid", ->
		it "should return `false` for an invalid address", ->
			isFalse new InternetAddress("").isValid
			isFalse new InternetAddress("159.180.abc.xyz").isValid
			isFalse new InternetAddress("2z01:e0y:59m:1t20:5oo5:62g5:a8s8:1493").isValid

		it "should return `true` for a valid address", ->
			isTrue new InternetAddress("::1").isValid
			isTrue new InternetAddress("192.168.100.1").isValid
			isTrue new InternetAddress("::ffff:192.168.100.1").isValid
			isTrue new InternetAddress("2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493").isValid

	describe "type", ->
		it "should return `InternetAddress.IPv4` for an IPv4", ->
			equal new InternetAddress("192.168.100.1").type, InternetAddressType.IPv4

		it "should return `InternetAddress.IPv6` for an IPv6", ->
			equal new InternetAddress("::1").type, InternetAddressType.IPv6
			equal new InternetAddress("::ffff:192.168.100.1").type, InternetAddressType.IPv6
			equal new InternetAddress("2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493").type, InternetAddressType.IPv6
