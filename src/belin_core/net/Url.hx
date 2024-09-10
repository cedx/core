package belin_core.net;

import tink.Url as TinkUrl;
using StringTools;

/** Represents a Uniform Resource Locator (URL), a link to a resource on the World Wide Web. **/
@:forward
@:jsonParse(json -> new belin_core.net.Url(json))
@:jsonStringify(url -> url.toString())
abstract Url(TinkUrl) from TinkUrl to TinkUrl {

	/** The regular expression used to validate a URL. **/
	public static final pattern = ~/^https?:\/\/(([a-z\d][a-z\d_-]*)(\.[a-z\d][a-z\d_-]*)+)(?::\d{1,5})?(?:$|[?\/#])/i;

	/** Value indicating whether this URL is empty. **/
	public var isEmpty(get, never): Bool;
		function get_isEmpty() return toString().length == 0;

	/** Value indicating whether this URL is valid. **/
	public var isValid(get, never): Bool;
		inline function get_isValid() return pattern.match(toString());

	/** Creates a new URL. **/
	public function new(value: String, defaultScheme = "https") {
		final url = value.trim();
		this = TinkUrl.parse(url.length > 0 && !~/^https?:/i.match(url) ? '$defaultScheme://$url' : url);
	}

	/** Creates a new phone number from the specified string. **/
	@:from static inline function ofString(value: String): Url
		return new Url(value);

	/** Returns a string representation of this object. **/
	@:to public inline function toString(): String
		return this.toString();
}
