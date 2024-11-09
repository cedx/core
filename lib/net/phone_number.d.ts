/**
 * Represents a phone number.
 */
export class PhoneNumber {

	/**
	 * The regular expression used to validate a phone number.
	 */
	static pattern: RegExp;

	/**
	 * Value indicating whether this phone number is empty.
	 */
	readonly isEmpty: boolean;

	/**
	 * Value indicating whether this phone number is valid.
	 */
	readonly isValid: boolean;

	/**
	 * Creates a new phone number.
	 * @param value The phone number.
	 */
	constructor(value: string);

	/**
	 * Formats this phone number according to the locale.
	 * @returns The formatted phone number.
	 */
	format(): string;

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
