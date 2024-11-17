/**
 * Converts the first character to uppercase.
 * @param value The string to process.
 * @returns The processed string.
 */
export function capitalize(value: string): string;

/**
 * Replaces all new lines in the specified value by HTML line breaks.
 * @param value The string to format.
 * @returns The formatted string.
 */
export function newLineToBr(value: string): string;

/**
 * Reverses the specified string.
 * @param value The string to reverse.
 * @returns The reversed string.
 */
export function reverse(value: string): string;

/**
 * Converts a string to an array.
 * @param value The string to split into characters or chunks.
 * @param splitLength The maximum length of the chunks.
 * @returns An array whose elements contain the characters or chunks.
 */
export function split(value: string, splitLength?: number): Array<string>;

/**
 * Removes the HTML tags from the specified string.
 * @param value The string to process.
 * @returns The processed string.
 */
export function stripTags(value: string): string;

/**
 * Removes whitespace from both ends of the items of the specified array.
 * @param array The array to process.
 * @returns The input array.
 */
export function trimArray(array: Array<unknown>): Array<any>;

/**
 * Removes whitespace from both ends of the properties of the specified object.
 * @param object The object to process.
 * @returns The input object.
 */
export function trimObject(object: Record<string, unknown>): Record<string, any>;

/**
 * Truncates the specified string to the given number of characters.
 * @param value The string to be truncated.
 * @param length The maximum length.
 * @param ellipsis The ellipsis to append to the truncated text.
 * @returns The truncated string.
 */
export function truncate(value: string, length: number, ellipsis?: string): string;

/**
 * Replaces invalid XML characters in a string with their valid XML equivalent.
 * @param value The string to process.
 * @returns The processed string.
 */
export function xmlEscape(value: string): string;
