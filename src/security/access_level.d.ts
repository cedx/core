/**
 * Defines the access level associated to a feature or a permission.
 */
export const AccessLevel: Readonly<{

	/**
	 * The read access.
	 */
	read: "read",

	/**
	 * The write access.
	 */
	write: "write",

	/**
	 * The administrator access.
	 */
	admin: "admin"
}>;

/**
 * Defines the access level associated to a feature or a permission.
 */
export type AccessLevel = typeof AccessLevel[keyof typeof AccessLevel];

/**
 * Returns a value indicating whether the first access level is greater than the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is greater than the second, otherwise `false`.
 */
export function greaterThan(x: AccessLevel, y: AccessLevel): boolean;

/**
 * Returns a value indicating whether the first access level is greater than or equal to the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is greater than or equal to the second, otherwise `false`.
 */
export function greaterThanOrEqual(x: AccessLevel, y: AccessLevel): boolean;

/**
 * Returns a value indicating whether the first access level is less than the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is less than the second, otherwise `false`.
 */
export function lessThan(x: AccessLevel, y: AccessLevel): boolean;

/**
 * Returns a value indicating whether the first access level is less than or equal to the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is less than or equal to the second, otherwise `false`.
 */
export function lessThanOrEqual(x: AccessLevel, y: AccessLevel): boolean;