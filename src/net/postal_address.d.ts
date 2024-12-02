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
	constructor(options?: PostalAddressOptions);

	/**
	 * Returns a string representation of this object.
	 * @param locale The current locale.
	 * @returns The string representation of this object.
	 */
	toString(locale?: Intl.Locale|string): string;
}

/**
 * Defines the options of an {@link PostalAddress} instance.
 */
export type PostalAddressOptions = Partial<{

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
}>;
