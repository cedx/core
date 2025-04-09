/**
 * Defines the access level associated to a feature or a permission.
 */
export const AccessLevel = Object.freeze({

	/**
	 * The read access.
	 */
	Read: "read",

	/**
	 * The write access.
	 */
	Write: "write",

	/**
	 * The administrator access.
	 */
	Admin: "admin"
});

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
export function greaterThan(x: AccessLevel, y: AccessLevel): boolean {
	if (x == AccessLevel.Write) return y == AccessLevel.Read;
	if (x == AccessLevel.Admin) return y == AccessLevel.Read || y == AccessLevel.Write;
	return false;
}

/**
 * Returns a value indicating whether the first access level is greater than or equal to the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is greater than or equal to the second, otherwise `false`.
 */
export function greaterThanOrEqual(x: AccessLevel, y: AccessLevel): boolean {
	if (x == AccessLevel.Read) return y == AccessLevel.Read;
	if (x == AccessLevel.Write) return y == AccessLevel.Read || y == AccessLevel.Write;
	return true;
}

/**
 * Returns a value indicating whether the first access level is less than the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is less than the second, otherwise `false`.
 */
export function lessThan(x: AccessLevel, y: AccessLevel): boolean {
	return !greaterThanOrEqual(x, y);
}

/**
 * Returns a value indicating whether the first access level is less than or equal to the second.
 * @param x The first access level.
 * @param y The second access level.
 * @returns `true` if the first access level is less than or equal to the second, otherwise `false`.
 */
export function lessThanOrEqual(x: AccessLevel, y: AccessLevel): boolean {
	return !greaterThan(x, y);
}
