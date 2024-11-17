/**
 * Represents a country/region.
 */
export class Region {

	/**
	 * The ISO 3166-1 alpha-2 code.
	 */
	code: string;

	/**
	 * The emoji flag corresponding to this region.
	 */
	readonly emojiFlag: string;

	/**
	 * Creates a new region.
	 * @param code The ISO 3166-1 alpha-2 code.
	 */
	constructor(code: string);

	/**
	 * Returns an appropriately localized display name for the specified locale.
	 * @param locale The target locale.
	 * @returns The localized display name in the specified locale.
	 */
	displayName(locale: Intl.Locale|string): string;

	/**
	 * Returns a JSON representation of this object.
	 * @returns The JSON representation of this object.
	 */
	toJSON(): string;

	/**
	 * Returns a string representation of this object.
	 * @returns The string representation of this object.
	 */
	toString(): string;
}
