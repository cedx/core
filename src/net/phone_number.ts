import {reverse, split} from "../util/string.js";

/**
 * Represents a phone number.
 */
export class PhoneNumber {

	/**
	 * The regular expression used to validate a phone number.
	 */
	static readonly pattern = /^[+0]\d{9,}$/;

	/**
	 * The normalized phone number.
	 */
	readonly #value: string;

	/**
	 * Creates a new phone number.
	 * @param value The phone number.
	 */
	constructor(value: string) {
		this.#value = this.#normalize(value.trim());
	}

	/**
	 * Value indicating whether this phone number is empty.
	 */
	get isEmpty(): boolean {
		return !this.#value.length;
	}

	/**
	 * Value indicating whether this phone number is valid.
	 */
	get isValid(): boolean {
		return PhoneNumber.pattern.test(this.#value);
	}

	/**
	 * Formats this phone number according to the locale.
	 * @returns The formatted phone number.
	 */
	format(): string {
		if (!this.#value) return "";
		const prefix = this.#value.startsWith("+33") ? "0" : `${this.#value.slice(0, 3)} `;
		return prefix + reverse(split(reverse(this.#value.slice(3)), 2).join(" "));
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

	/**
	 * Normalizes the specified phone number.
	 * @param value A raw phone number.
	 * @returns The normalized phone number.
	 */
	#normalize(value: string): string {
		if (value.startsWith("00")) value = `+${value.slice(2)}`;
		else if (value.startsWith("0")) value = `+33${value.slice(1)}`;
		return value.replace(/[\s/.,;:-]/g, "");
	}
}
