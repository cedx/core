/**
 * Returns a value indicating whether the specified number is a numeric identifier, i.e. a positive integer greater than zero.
 * @param value The value to check.
 * @returns `true` if the specified number is a numeric identifier, otherwise `false`.
 */
export function isIdentifier(value: number): boolean;

/**
 * Rounds a floating-point number.
 * @param value The value to round.
 * @param precision The optional number of decimal digits to round to.
 * @returns The value rounded to the given precision.
 */
export function round(value: number, precision?: number): number;
