/**
 * Represents an IP address.
 */
export class InternetAddress {

	/**
	 * The regular expression used to validate an IPv4 address.
	 */
	static ipv4Pattern: RegExp;

	/**
	 * The regular expression used to validate an IPv4 address.
	 */
	static ipv6Pattern: RegExp;

	/**
	 * The IPv6 numeric address.
	 */
	readonly address: string;

	/**
	 * Value indicating whether this IP address is empty.
	 */
	readonly isEmpty: boolean;

	/**
	 * Value indicating whether this IP address is valid.
	 */
	readonly isValid: boolean;

	/**
	 * The address family.
	 */
	readonly type: InternetAddressType;

	/**
	 * Creates a new IP address.
	 * @param value The IP address.
	 */
	constructor(value: string);
}

/**
 * Defines the address family of an IP address.
 */
export const InternetAddressType: Readonly<{

	/**
	 * An IPv4 address.
	 */
	IPv4: 4,

	/**
	 * An IPv6 address.
	 */
	IPv6: 6
}>;

/**
 * Defines the address family of an IP address.
 */
export type InternetAddressType = typeof InternetAddressType[keyof typeof InternetAddressType];
