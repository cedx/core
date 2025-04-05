/**
 * Defines the address family of an IP address.
 */
export const InternetAddressType = Object.freeze({

	/**
	 * An IPv4 address.
	 */
	IPv4: 4,

	/**
	 * An IPv6 address.
	 */
	IPv6: 6
});

/**
 * Defines the address family of an IP address.
 */
export type InternetAddressType = typeof InternetAddressType[keyof typeof InternetAddressType];

/**
 * Represents an IP address.
 */
export class InternetAddress {

	/**
	 * The regular expression used to validate an IPv4 address.
	 */
	static readonly ipv4Pattern = /^(?:(?:2(?:[0-4]\d|5[0-5])|[0-1]?\d?\d)\.){3}(?:2([0-4]\d|5[0-5])|[0-1]?\d?\d)$/;

	/**
	 * The regular expression used to validate an IPv4 address.
	 */
	static readonly ipv6Pattern = /^(([a-f\d]{1,4}:){7}[a-f\d]{1,4}|([a-f\d]{1,4}:){1,7}:|([a-f\d]{1,4}:){1,6}:[a-f\d]{1,4}|([a-f\d]{1,4}:){1,5}(:[a-f\d]{1,4}){1,2}|([a-f\d]{1,4}:){1,4}(:[a-f\d]{1,4}){1,3}|([a-f\d]{1,4}:){1,3}(:[a-f\d]{1,4}){1,4}|([a-f\d]{1,4}:){1,2}(:[a-f\d]{1,4}){1,5}|[a-f\d]{1,4}:((:[a-f\d]{1,4}){1,6})|:((:[a-f\d]{1,4}){1,7}|:)|fe80:(:[a-f\d]{0,4}){0,4}%[a-z\d]+|::(ffff(:0{1,4})?:)?((25[0-5]|(2[0-4]|1?\d)?\d)\.){3}(25[0-5]|(2[0-4]|1?\d)?\d)|([a-f\d]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1?\d)?\d)\.){3}(25[0-5]|(2[0-4]|1?\d)?\d))$/;

	/**
	 * The normalized address.
	 */
	readonly #value: string;

	/**
	 * Creates a new IP address.
	 * @param value The IP address.
	 */
	constructor(value: string) {
		this.#value = this.#sanitize(value.trim().toLowerCase());
	}

	/**
	 * The IPv6 numeric address.
	 */
	get address(): string {
		return this.type == InternetAddressType.IPv4 ? `::ffff:${this.#value}` : this.#value;
	}

	/**
	 * Value indicating whether this IP address is empty.
	 */
	get isEmpty(): boolean {
		return !this.#value.length;
	}

	/**
	 * Value indicating whether this IP address is valid.
	 */
	get isValid(): boolean {
		return this.type == InternetAddressType.IPv4 ? InternetAddress.ipv4Pattern.test(this.#value) : InternetAddress.ipv6Pattern.test(this.#value);
	}

	/**
	 * The address family.
	 */
	get type(): InternetAddressType {
		return this.#value.includes(":") ? InternetAddressType.IPv6 : InternetAddressType.IPv4;
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
	 * Sanitizes the specified IP address.
	 * @param value A raw IP address.
	 * @returns The sanitized IP address.
	 */
	#sanitize(value: string): string {
		const parts = value.split(":");
		if (parts.length == 2) return parts[0];
		const matches = /^\[(.+)](:\d+)?$/.exec(value);
		return matches ? matches[1] : value;
	}
}
