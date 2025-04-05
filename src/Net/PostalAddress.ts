/**
 * Represents a postal address.
 */
export class PostalAddress {

	/**
	 * The first address line.
	 */
	address1: string;

	/**
	 * The second address line.
	 */
	address2: string;

	/**
	 * The city.
	 */
	city: string;

	/**
	 * The country.
	 */
	country: string;

	/**
	 * The postal code.
	 */
	postalCode: string;

	/**
	 * Creates a new address.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(options: PostalAddressOptions = {}) {
		this.address1 = options.address1 ?? "";
		this.address2 = options.address2 ?? "";
		this.city = options.city ?? "";
		this.country = options.country ?? "";
		this.postalCode = options.postalCode ?? "";
	}

	/**
	 * Returns a string representation of this object.
	 * @param locale The current locale.
	 * @returns The string representation of this object.
	 */
	toString(locale: Intl.Locale|string = navigator.language): string {
		const lines = [this.address1, this.address2, `${this.postalCode} ${this.city}`, this.country.toLocaleUpperCase(locale)];
		return lines.map((item) => item.trim()).filter((item) => item.length).join("\n");
	}
}

/**
 * Defines the options of a {@link PostalAddress} instance.
 */
export type PostalAddressOptions = Partial<Omit<PostalAddress, "toString">>;
