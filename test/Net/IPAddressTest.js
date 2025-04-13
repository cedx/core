import {IPAddress, IPAddressType} from "@cedx/core/Net/IPAddress.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link IPAddress} class.
 */
describe("IPAddress", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("address", () => {
		it("should prefix the address with '::ffff:' for an IPv4", () =>
			equal(new IPAddress("192.168.100.1").address, "::ffff:192.168.100.1"));

		it("should normalize the address for an IPv6", () => {
			equal(new IPAddress("2A01:E0A:59B:1F20:5DD5:62F5:A8A8:1493").address, "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493");
			equal(new IPAddress("[2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493]").address, "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493");
		});

		it("should sanitize the address if it includes a port number", () => {
			equal(new IPAddress("192.168.100.1:1234").address, "::ffff:192.168.100.1");
			equal(new IPAddress("[::ffff:192.168.100.1]:1234").address, "::ffff:192.168.100.1");
			equal(new IPAddress("[2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493]:1234").address, "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493");
		});
	});

	describe("isEmpty", () => {
		it("should return `true` if the address is empty", () => {
			assert.isTrue(new IPAddress("").isEmpty);
			assert.isTrue(new IPAddress(" \r\n ").isEmpty);
		});

		it("should return `false` if the address is not empty", () => {
			assert.isFalse(new IPAddress("::1").isEmpty);
			assert.isFalse(new IPAddress("192.168.100.1").isEmpty);
		});
	});

	describe("isValid", () => {
		it("should return `false` for an invalid address", () => {
			assert.isFalse(new IPAddress("").isValid);
			assert.isFalse(new IPAddress("159.180.abc.xyz").isValid);
			assert.isFalse(new IPAddress("2z01:e0y:59m:1t20:5oo5:62g5:a8s8:1493").isValid);
		});

		it("should return `true` for a valid address", () => {
			assert.isTrue(new IPAddress("::1").isValid);
			assert.isTrue(new IPAddress("192.168.100.1").isValid);
			assert.isTrue(new IPAddress("::ffff:192.168.100.1").isValid);
			assert.isTrue(new IPAddress("2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493").isValid);
		});
	});

	describe("type", () => {
		it("should return `IPAddress.IPv4` for an IPv4", () =>
			equal(new IPAddress("192.168.100.1").type, IPAddressType.IPv4));

		it("should return `IPAddress.IPv6` for an IPv6", () => {
			equal(new IPAddress("::1").type, IPAddressType.IPv6);
			equal(new IPAddress("::ffff:192.168.100.1").type, IPAddressType.IPv6);
			equal(new IPAddress("2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493").type, IPAddressType.IPv6);
		});
	});
});
