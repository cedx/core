/**
 * Returns the date at midnight corresponding to the specified date.
 * @param date The source date.
 * @returns The date whose time has been set at midnight.
 */
export function atMidnight(date: Date): Date;

/**
 * Gets the number of days in the month of the specified date.
 * @param date The date.
 * @returns The number of days in the month of the specified date.
 */
export function daysInMonth(date: Date): number;

/**
 * Gets the date of Easter for a given year.
 * @param year The year.
 * @returns The date of Easter for the specified year.
 */
export function getEaster(year?: number): Date;

/**
 * Gets the list of holidays for a given year.
 * @param year The year.
 * @returns The list of holidays for the specified year.
 */
export function getHolidays(year?: number): Array<Date>;

/**
 * Gets the quarter corresponding to the specified date.
 * @param date The date.
 * @returns The quarter corresponding to the specified date.
 */
export function getQuarter(date: Date): number;

/**
 * Gets the week number corresponding to the specified date.
 * @param date The date.
 * @returns The week number corresponding to the specified date.
 */
export function getWeekOfYear(date: Date): number;

/**
 * Returns a value indicating whether the specified date is in a leap year.
 * @param date The date to check.
 * @returns `true` if the specified date is in a leap year, otherwise `false`.
 */
export function inLeapYear(date: Date): boolean;

/**
 * Returns a value indicating whether the specified date is a holiday.
 * @param date The date to check.
 * @returns `true` if the specified date is a holiday, otherwise `false`.
 */
export function isHoliday(date: Date): boolean;

/**
 * Returns a value indicating whether the specified date is a working day.
 * @param date The date to check.
 * @returns `true` if the specified date is a working day, otherwise `false`.
 */
export function isWorkingDay(date: Date): boolean;

/**
 * Converts the specified date to an ISO 8601 week.
 * @param date The date to convert.
 * @returns The ISO 8601 week corresponding to the specified date.
 */
export function toIsoWeek(date: Date): string;

/**
 * Converts the specified date to the `YYYY-MM-DD HH:MM:SS` format.
 * @param date The date to convert.
 * @param options Values indicating how to format the resulting string.
 * @returns The `YYYY-MM-DD HH:MM:SS` format corresponding to the specified date.
 */
export function toYmdHms(date: Date, options?: {excludeDate?: boolean, excludeTime?: boolean, separator?: string}): string;
