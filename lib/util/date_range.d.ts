/**
 * Defines a date range.
 */
export class DateRange {

	/**
	 * The end date.
	 */
	end: Date;

	/**
	 * The start date.
	 */
	start: Date;

	/**
	 * The range type.
	 */
	type: DateRangeType;

	/**
	 * Creates a new date range.
	 * @param start The start date.
	 * @param end The end date.
	 * @param type The range type.
	 */
	constructor(start: Date, end: Date, type?: DateRangeType);

	/**
	 * Creates a new date range from the specified JSON object.
	 * @param json A JSON object representing a date range.
	 * @returns The instance corresponding to the specified JSON object.
	 */
	static fromJson(json: Record<string, any>): DateRange;

	/**
	 * Creates a date range corresponding to the day including the specified date.
	 * @param date The date.
	 * @returns The date range corresponding to the day including the specified date.
	 */
	static day(date: Date): DateRange;

	/**
	 * Creates a date range corresponding to the month including the specified date.
	 * @param date The date.
	 * @returns The date range corresponding to the month including the specified date.
	 */
	static month(date: Date): DateRange;

	/**
	 * Creates a date range corresponding to the quarter including the specified date.
	 * @param date The date.
	 * @returns The date range corresponding to the quarter including the specified date.
	 */
	static quarter(date: Date): DateRange;

	/**
	 * Creates a date range corresponding to the week including the specified date.
	 * @param date The date.
	 * @returns The date range corresponding to the week including the specified date.
	 */
	static week(date: Date): DateRange;

	/**
	 * Creates a date range corresponding to the year including the specified date.
	 * @param date The date.
	 * @returns The date range corresponding to the year including the specified date.
	 */
	static year(date: Date): DateRange;

	/**
	 * Returns a value indicating whether this date range is equal to the specified date range.
	 * @param other The other date range to compare.
	 * @returns `true` if this date range is equal to the specified date range, otherwise `false`.
	 */
	equals(other: DateRange): boolean;
}

/**
 * Defines the type of a date range.
 */
export const DateRangeType: Readonly<{

	/**
	 * A custom date range.
	 */
	custom: "",

	/**
	 * A whole day.
	 */
	day: "P1D",

	/**
	 * A whole week.
	 */
	week: "P1W",

	/**
	 * A whole month.
	 */
	month: "P1M",

	/**
	 * A whole quarter.
	 */
	quarter: "P3M",

	/**
	 * A whole year.
	 */
	year: "P1Y"
}>;

/**
 * Defines the type of a date range.
 */
export type DateRangeType = typeof DateRangeType[keyof typeof DateRangeType];
