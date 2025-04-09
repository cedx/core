import {Duration} from "./Duration.js";

/**
 * Returns the date at midnight corresponding to the specified date.
 * @param date The source date.
 * @returns The date whose time has been set at midnight.
 */
export function atMidnight(date: Date): Date {
	return new Date(date.getFullYear(), date.getMonth(), date.getDate());
}

/**
 * Gets the number of days in the month of the specified date.
 * @param date The date.
 * @returns The number of days in the month of the specified date.
 */
export function daysInMonth(date: Date): number {
	return new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
}

/**
 * Gets the date of Easter for a given year.
 * @param year The year.
 * @returns The date of Easter for the specified year.
 */
export function getEaster(year = new Date().getFullYear()): Date {
	/* eslint-disable id-length */
	const n = year % 19;
	const c = Math.trunc(year / 100);
	const u = year % 100;
	const e = ((19 * n) + c - Math.trunc(c / 4) - Math.trunc((c - Math.trunc((c + 8) / 25) + 1) / 3) + 15) % 30;
	const l = ((2 * (c % 4)) + (2 * Math.trunc(u / 4)) - e - (u % 4) + 32) % 7;
	const h = Math.trunc((n + (11 * e) + (22 * l)) / 451);
	const result = e + l - (7 * h) + 114;
	/* eslint-enable id-length */

	return new Date(year, Math.trunc(result / 31) - 1, (result % 31) + 1);
}

/**
 * Gets the list of holidays for a given year.
 * @param year The year.
 * @returns The list of holidays for the specified year.
 */
export function getHolidays(year = new Date().getFullYear()): Date[] {
	const holidays = [];

	// Fixed holidays.
	holidays.push(new Date(year, 0, 1)); // New year.
	holidays.push(new Date(year, 4, 1)); // Labor day.
	holidays.push(new Date(year, 4, 8)); // Armistice (1945).
	holidays.push(new Date(year, 6, 14)); // National holiday.
	holidays.push(new Date(year, 7, 15)); // Assumption.
	holidays.push(new Date(year, 10, 1)); // Toussaint.
	holidays.push(new Date(year, 10, 11)); // Armistice (1918).
	holidays.push(new Date(year, 11, 25)); // Christmas.

	// Holidays depending on Easter.
	const easter = getEaster(year);
	holidays.push(new Date(easter.getTime() + Duration.Day)); // Easter monday.
	holidays.push(new Date(easter.getTime() + (39 * Duration.Day))); // Ascension thursday.
	holidays.push(new Date(easter.getTime() + (50 * Duration.Day))); // Pentecost monday.

	return holidays;
}

/**
 * Gets the quarter corresponding to the specified date.
 * @param date The date.
 * @returns The quarter corresponding to the specified date.
 */
export function getQuarter(date: Date): number {
	return Math.ceil((date.getMonth() + 1) / 3);
}

/**
 * Gets the week number corresponding to the specified date.
 * @param date The date.
 * @returns The week number corresponding to the specified date.
 */
export function getWeekOfYear(date: Date): number {
	const thursday = new Date(date.getFullYear(), date.getMonth(), date.getDate() + 3 - ((date.getDay() + 6) % 7));
	const firstWeek = new Date(thursday.getFullYear(), 0, 4);
	return 1 + Math.round((((thursday.getTime() - firstWeek.getTime()) / Duration.Day) - 3 + ((firstWeek.getDay() + 6) % 7)) / 7);
}

/**
 * Returns a value indicating whether the specified date is in a leap year.
 * @param date The date to check.
 * @returns `true` if the specified date is in a leap year, otherwise `false`.
 */
export function inLeapYear(date: Date): boolean {
	const year = date.getFullYear();
	return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

/**
 * Returns a value indicating whether the specified date is a holiday.
 * @param date The date to check.
 * @returns `true` if the specified date is a holiday, otherwise `false`.
 */
export function isHoliday(date: Date): boolean {
	const timestamp = atMidnight(date).getTime();
	return getHolidays(date.getFullYear()).some(holiday => holiday.getTime() == timestamp);
}

/**
 * Returns a value indicating whether the specified date is a working day.
 * @param date The date to check.
 * @returns `true` if the specified date is a working day, otherwise `false`.
 */
export function isWorkingDay(date: Date): boolean {
	const dayOfWeek = date.getDay();
	return dayOfWeek >= 1 && dayOfWeek <= 5;
}

/**
 * Converts the specified date to an ISO 8601 week.
 * @param date The date to convert.
 * @returns The ISO 8601 week corresponding to the specified date.
 */
export function toIsoWeek(date: Date): string {
	return `${date.getFullYear().toString().padStart(4, "0")}-W${getWeekOfYear(date).toString().padStart(2, "0")}`;
}

/**
 * Converts the specified date to the `YYYY-MM-DD HH:MM:SS` format.
 * @param date The date to convert.
 * @param options Values indicating how to format the resulting string.
 * @returns The `YYYY-MM-DD HH:MM:SS` format corresponding to the specified date.
 */
export function toYmdHms(date: Date, options: {excludeDate?: boolean, excludeTime?: boolean, separator?: string} = {}): string {
	const padStart = (number: number, length = 2): string => number.toString().padStart(length, "0");
	const parts = [];
	if (!options.excludeDate) parts.push([padStart(date.getFullYear(), 4), padStart(date.getMonth() + 1), padStart(date.getDate())].join("-"));
	if (!options.excludeTime) parts.push([date.getHours(), date.getMinutes(), date.getSeconds()].map(item => padStart(item)).join(":"));
	return parts.join(options.separator ?? " ");
}
