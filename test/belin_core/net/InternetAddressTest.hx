package belin_core.net;

import belin_core.net.InternetAddress.InternetAddressType;

/** Tests the features of the `InternetAddress` class. **/
final class InternetAddressTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `address` property. **/
	@:variant("192.168.100.36", "::ffff:192.168.100.36")
	@:variant("192.168.100.36:1234", "::ffff:192.168.100.36")
	@:variant("[::ffff:192.168.100.36]:1234", "::ffff:192.168.100.36")
	@:variant("2A01:E0A:59B:1F20:5DD5:62F5:A8A8:1493", "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493")
	@:variant("[2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493]", "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493")
	@:variant("[2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493]:1234", "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493")
	public function address(input: String, output: String)
		return assert(new InternetAddress(input).address == output);

	/** Tests the `isEmpty` property. **/
	@:variant("", true)
	@:variant(" \r\n ", true)
	@:variant("::1", false)
	@:variant("192.168.100.36", false)
	public function isEmpty(input: String, output: Bool)
		return assert(new InternetAddress(input).isEmpty == output);

	/** Tests the `isValid` property. **/
	@:variant("", false)
	@:variant("159.180.abc.xyz", false)
	@:variant("2z01:e0y:59m:1t20:5oo5:62g5:a8s8:1493", false)
	@:variant("::1", true)
	@:variant("192.168.100.36", true)
	@:variant("::ffff:192.168.100.36", true)
	@:variant("2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493", true)
	public function isValid(input: String, output: Bool)
		return assert(new InternetAddress(input).isValid == output);

	/** Tests the `type` property. **/
	@:variant("192.168.100.36", IPv4)
	@:variant("::ffff:192.168.100.36", IPv6)
	@:variant("2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493", IPv6)
	public function type(input: String, output: InternetAddressType)
		return assert(new InternetAddress(input).type == output);

	/** Tests the `ofString()` method. **/
	@:variant("192.168.100.36", "192.168.100.36")
	@:variant("::FFFF:192.168.100.36", "::ffff:192.168.100.36")
	@:variant("2A01:E0A:59B:1F20:5DD5:62F5:A8A8:1493", "2a01:e0a:59b:1f20:5dd5:62f5:a8a8:1493")
	public function ofString(input: String, output: String)
		return assert((input: InternetAddress) == output);
}
