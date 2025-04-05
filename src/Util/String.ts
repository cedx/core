/**
 * The mapping between special characters and the corresponding XML entities.
 */
const xmlEntities = new Map([
	["&", "&amp;"],
	["<", "&lt;"],
	[">", "&gt;"],
	['"', "&quot;"],
	["'", "&#39;"]
]);

/**
 * Converts the first character to uppercase.
 * @param value The string to process.
 * @param locale The current locale.
 * @returns The processed string.
 */
export function capitalize(value: string, locale: Intl.Locale|string = navigator.language): string {
	return value.charAt(0).toLocaleUpperCase(locale) + value.slice(1);
}

/**
 * Replaces all new lines in the specified value by HTML line breaks.
 * @param value The string to format.
 * @returns The formatted string.
 */
export function newLineToBr(value: string): string {
	return value.split(/\r?\n/g).join("<br>");
}

/**
 * Reverses the specified string.
 * @param value The string to reverse.
 * @returns The reversed string.
 */
export function reverse(value: string): string {
	return Array.from(value).reverse().join("");
}

/**
 * Converts a string to an array.
 * @param value The string to split into characters or chunks.
 * @param splitLength The maximum length of the chunks.
 * @returns An array whose elements contain the characters or chunks.
 */
export function split(value: string, splitLength = 1): string[] {
	return splitLength == 1 ? Array.from(value) : (value.match(new RegExp(`.{1,${splitLength}}`, "gsy")) ?? []);
}

/**
 * Removes the HTML tags from the specified string.
 * @param value The string to process.
 * @returns The processed string.
 */
export function stripTags(value: string): string {
	return value.replace(/<[^>]+>/g, "");
}

/**
 * Removes whitespace from both ends of the items of the specified array.
 * @param array The array to process.
 * @returns The input array.
 */
export function trimArray(array: unknown[]): any[] {
	for (const [index, value] of array.entries()) if (typeof value == "string") array[index] = value.trim();
	return array;
}

/**
 * Removes whitespace from both ends of the properties of the specified object.
 * @param object The object to process.
 * @returns The input object.
 */
export function trimObject(object: Record<string, unknown>): Record<string, any> {
	for (const [key, value] of Object.entries(object)) if (typeof value == "string") object[key] = value.trim();
	return object;
}

/**
 * Truncates the specified string to the given number of characters.
 * @param value The string to be truncated.
 * @param length The maximum length.
 * @param ellipsis The ellipsis to append to the truncated text.
 * @returns The truncated string.
 */
export function truncate(value: string, length: number, ellipsis = "..."): string {
	return value.length > length ? value.slice(0, length) + ellipsis : value;
}

/**
 * Replaces invalid XML characters in a string with their valid XML equivalent.
 * @param value The string to process.
 * @returns The processed string.
 */
export function xmlEscape(value: string): string {
	return value.replace(/[&<>"']/g, character => xmlEntities.get(character) ?? character);
}
