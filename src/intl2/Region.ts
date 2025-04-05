/**
 * Represents a country/region.
 */
export class Region {

	/**
	 * The ISO 3166-1 alpha-2 code.
	 */
	readonly code: string;

	/**
	 * Creates a new region.
	 * @param code The ISO 3166-1 alpha-2 code.
	 */
	constructor(code: string) {
		this.code = code.toUpperCase();
	}

	/**
	 * The emoji flag corresponding to this region.
	 */
	get emojiFlag(): string {
		return String.fromCodePoint(127_397 + this.code.charCodeAt(0), 127_397 + this.code.charCodeAt(1));
	}

	/**
	 * Returns an appropriately localized display name for the specified locale.
	 * @param locale The target locale.
	 * @returns The localized display name in the specified locale.
	 */
	displayName(locale: Intl.Locale|string = navigator.language): string {
		return new Intl.DisplayNames(locale, {type: "region"}).of(this.code) ?? this.code;
	}

	/**
	 * Returns a JSON representation of this object.
	 * @returns The JSON representation of this object.
	 */
	toJSON(): string {
		return this.toString();
	}

	/**
	 * Returns a string representation of this object.
	 * @returns The string representation of this object.
	 */
	toString(): string {
		return this.code;
	}
}
