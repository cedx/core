/**
 * Represents a mail address.
 */
export class MailAddress {

	/**
	 * The normalized address.
	 */
	readonly #value: string;

	/**
	 * Creates a new mail address.
	 * @param value The mail address.
	 */
	constructor(value: string) {
		this.#value = value.trim().toLowerCase();
	}

	/**
	 * The host portion of the address.
	 */
	get host(): string {
		return this.#value.split("@").at(-1) ?? "";
	}

	/**
	 * Value indicating whether this mail address is empty.
	 */
	get isEmpty(): boolean {
		return !this.#value.length;
	}

	/**
	 * Value indicating whether this mail address is valid.
	 */
	get isValid(): boolean {
		const index = this.#value.indexOf("@");
		return index > 0 && index < this.#value.length - 1 && index == this.#value.lastIndexOf("@");
	}

	/**
	 * The user information.
	 */
	get user(): string {
		return this.#value.split("@").at(0) ?? "";
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
		return this.#value;
	}
}
