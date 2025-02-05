/**
 * Rounds a floating-point number.
 * @param value The value to round.
 * @param precision The optional number of decimal digits to round to.
 * @returns The value rounded to the given precision.
 */
export function round(value: number, precision = 0): number {
	const operand = 10 ** precision;
	return Math.round(value * operand) / operand;
}
