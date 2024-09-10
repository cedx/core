package belin_core;

/** Provides static extensions for strings. **/
abstract class StringTools {

	/** Converts the first letter of the specified string to upper case. **/
	public static function capitalize(value: String): String
		return value.charAt(0).toUpperCase() + value.substr(1);

	/** Replaces all new lines by HTML line breaks in the specified string. **/
	public static function newLineToBr(value: String): String
		return ~/\r?\n/g.replace(value, "<br>");

	/** Reverses the specified string. **/
	public static function reverse(value: String): String {
		final characters = value.split("");
		characters.reverse();
		return characters.join("");
	}

	/** Converts a string to an array. **/
	public static function split(value: String, splitLength = 1): Array<String> {
		if (splitLength <= 1) return value.split("");
		if (splitLength >= value.length) return [value];

		final regex = new EReg('.{1,$splitLength}', "s");
		return [while (regex.match(value)) {
			value = regex.matchedRight();
			regex.matched(0);
		}];
	}

	/** Removes the HTML tags from the specified string. **/
	public static function stripTags(value: String): String
		return ~/<[^>]+>/g.replace(value, "");

	/** Truncates the specified string to the given number of characters. **/
	public static function truncate(value: String, length: Int, ellipsis = "..."): String
		return value.length > length ? value.substr(0, length) + ellipsis : value;
}
