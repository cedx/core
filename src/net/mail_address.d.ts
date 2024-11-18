/**
 * Represents a mail address.
 */
export class MailAddress {

	/**
	 * The regular expression used to validate a mail address.
	 */
	static pattern: RegExp;

	/**
	 * The host portion of the address.
	 */
	readonly host: string;

	/**
	 * Value indicating whether this mail address is empty.
	 */
	readonly isEmpty: boolean;

	/**
	 * Value indicating whether this mail address is valid.
	 */
	readonly isValid: boolean;

	/**
	 * The user information.
	 */
	readonly user: string;

	/**
	 * Creates a new mail address.
	 * @param value The mail address.
	 */
	constructor(value: string);
}
