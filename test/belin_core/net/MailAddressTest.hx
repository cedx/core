package belin_core.net;

/** Tests the features of the `MailAddress` class. **/
final class MailAddressTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `host` property. **/
	@:variant("Foo.Bar@Domain.TLD", "domain.tld")
	@:variant("teßt@täst.de", "täst.de")
	public function host(input: String, output: String)
		return assert(new MailAddress(input).host == output);

	/** Tests the `isEmpty` property. **/
	@:variant("", true)
	@:variant(" \r\n ", true)
	@:variant("dev@belin.io", false)
	public function isEmpty(input: String, output: Bool)
		return assert(new MailAddress(input).isEmpty == output);

	/** Tests the `isValid` property. **/
	@:variant("", false)
	@:variant("dev@", false)
	@:variant("@belin.io", false)
	@:variant("dev@belin.io", true)
	@:variant("foo-bar.baz-qux@foo.bar.baz.qux.tld", true)
	public function isValid(input: String, output: Bool)
		return assert(new MailAddress(input).isValid == output);

	/** Tests the `user` property. **/
	@:variant("Foo.Bar@Domain.TLD", "foo.bar")
	@:variant("teßt@täst.de", "teßt")
	public function user(input: String, output: String)
		return assert(new MailAddress(input).user == output);

	#if php
	/** Tests the `checkDns()` method. **/
	@:variant("", false)
	@:variant("dev@", false)
	@:variant("@belin.io", false)
	@:variant("dev@belin.io", true)
	@:variant("foo-bar.baz-qux@foo.bar.baz.qux.tld", false)
	public function checkDns(input: String, output: Bool)
		return assert(new MailAddress(input).checkDns() == output);
	#end
}
