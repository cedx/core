/**
 * Provides some common durations in milliseconds.
 */
export const Duration = Object.freeze({

	/**
	 * One second.
	 */
	Second: 1_000,

	/**
	 * One minute.
	 */
	Minute: 60_000,

	/**
	 * One hour.
	 */
	Hour: 3_600_000,

	/**
	 * One day.
	 */
	Day: 86_400_000
});

/**
 * Provides some common durations in milliseconds.
 */
export type Duration = typeof Duration[keyof typeof Duration];
