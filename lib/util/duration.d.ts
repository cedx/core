/**
 * Provides some common durations in milliseconds.
 */
export const Duration: Readonly<{

	/**
	 * One second.
	 */
	second: 1_000,

	/**
	 * One minute.
	 */
	minute: 60_000,

	/**
	 * One hour.
	 */
	hour: 3_600_000,

	/**
	 * One day.
	 */
	day: 86_400_000
}>;

/**
 * Provides some common durations in milliseconds.
 */
export type Duration = typeof Duration[keyof typeof Duration];
