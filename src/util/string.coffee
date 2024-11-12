# The mapping between special characters and the corresponding XML entities.
xmlEntities = new Map [
	["&", "&amp;"]
	["<", "&lt;"]
	[">", "&gt;"]
	['"', "&quot;"]
	["'", "&#39;"]
]

# Converts the first character to uppercase.
export capitalize = (value) -> value.charAt(0).toLocaleUpperCase() + value[1..]

# Replaces all new lines in the specified value by HTML line breaks.
export newLineToBr = (value) -> value.split(/\r?\n/g).join "<br>"

# Reverses the specified string.
export reverse = (value) -> Array.from(value).reverse().join ""

# Converts a string to an array.
export split = (value, splitLength = 1) ->
	if splitLength is 1 then Array.from value else value.match(new RegExp(".{1,#{splitLength}}", "gsy")) or []

# Removes the HTML tags from the specified string.
export stripTags = (value) -> value.replace /<[^>]+>/g, ""

# Removes whitespace from both ends of the items of the specified array.
export trimArray = (array) ->
	array[index] = value.trim() for [index, value] from array.entries() when typeof value is "string"
	array

# Removes whitespace from both ends of the properties of the specified object.
export trimObject = (object) ->
	object[key] = value.trim() for [key, value] from Object.entries object when typeof value is "string"
	object

# Truncates the specified string to the given number of characters.
export truncate = (value, length, ellipsis = "...") ->
	if value.length > length then value[...length] + ellipsis else value

# Replaces invalid XML characters in a string with their valid XML equivalent.
export xmlEscape = (value) -> value.replace /[&<>"']/g, (character) -> xmlEntities.get(character) or character
