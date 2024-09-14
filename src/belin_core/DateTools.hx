package belin_core;

#if php
import php.DateTimeInterface;
import php.Global;
#end
using DateTools;
using Lambda;
using StringTools;

/** Provides static extensions for dates. **/
abstract class DateTools {

	/** Returns the date at midnight corresponding to the specified date. **/
	public static function atMidnight(date: Date): Date
		return new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);

	/** Gets the number of days in the month of the specified date. **/
	public static function daysInMonth(date: Date): Int return
		#if php Std.parseInt(Global.date("t", Std.int(date.getTime() / 1.seconds())))
		#else new Date(date.getFullYear(), date.getMonth() + 1, 0, 0, 0, 0).getDate() #end;

	/** Gets the date of Easter for a given `year`. **/
	public static function getEaster(year: Int): Date {
		final n = year % 19;
		final c = Std.int(year / 100);
		final u = year % 100;
		final e = ((19 * n) + c - Std.int(c / 4) - Std.int((c - Std.int((c + 8) / 25) + 1) / 3) + 15) % 30;
		final l = ((2 * (c % 4)) + (2 * Std.int(u / 4)) - e - (u % 4) + 32) % 7;
		final h = Std.int((n + (11 * e) + (22 * l)) / 451);
		final result = e + l - (7 * h) + 114;

		return new Date(year, Std.int(result / 31) - 1, (result % 31) + 1, 0, 0, 0);
	}

	/** Gets the list of holidays for a given `year`. **/
	public static function getHolidays(year: Int): Array<Date> {
		final easter = getEaster(year);
		final holidays = [];

		// Fixed holidays.
		holidays.push(new Date(year, 0, 1, 0, 0, 0)); // New year's day.
		holidays.push(new Date(year, 4, 1, 0, 0, 0)); // Labor day.
		holidays.push(new Date(year, 4, 8, 0, 0, 0)); // Armistice (1945).
		holidays.push(new Date(year, 6, 14, 0, 0, 0)); // National holiday.
		holidays.push(new Date(year, 7, 15, 0, 0, 0)); // Assumption.
		holidays.push(new Date(year, 10, 1, 0, 0, 0)); // Toussaint.
		holidays.push(new Date(year, 10, 11, 0, 0, 0)); // Armistice (1918).
		holidays.push(new Date(year, 11, 25, 0, 0, 0)); // Christmas.

		// Holidays depending on Easter.
		holidays.push(easter.delta(1.days())); // Easter monday.
		holidays.push(easter.delta(39.days())); // Ascension thursday.
		holidays.push(easter.delta(50.days())); // Pentecost monday.

		return holidays;
	}

	/** Gets the quarter corresponding to the specified `date`. **/
	public static function getQuarter(date: Date): Int
		return Math.ceil((date.getMonth() + 1) / 3);

	// TODO use DateRange !
	/** Gets the first and last day of the week encompassing the specified date. **/
	public static function getWeek(date: Date): Pair<Date, Date> {
		final delta = -((date.getDay() + 6) % 7);
		final monday = date.delta(delta.days());
		final sunday = date.delta((delta + 6).days());
		return new Pair(
			new Date(monday.getFullYear(), monday.getMonth(), monday.getDate(), 0, 0, 0),
			new Date(sunday.getFullYear(), sunday.getMonth(), sunday.getDate(), 23, 59, 59)
		);
	}

	/** Gets the week number corresponding to the specified date. **/
	public static function getWeekOfYear(date: Date): Int {
		#if php
			return Std.parseInt(Global.date("W", Std.int(date.getTime() / 1.seconds())));
		#else
			final thursday = new Date(date.getFullYear(), date.getMonth(), date.getDate() + 3 - ((date.getDay() + 6) % 7), 0, 0, 0);
			final firstWeek = new Date(thursday.getFullYear(), 0, 4, 0, 0, 0);
			return 1 + Math.round((((thursday.getTime() - firstWeek.getTime()) / 1.days()) - 3 + ((firstWeek.getDay() + 6) % 7)) / 7);
		#end
	}

	/** Gets a value indicating whether the specified date is in a leap year. **/
	public static function inLeapYear(date: Date): Bool {
		final year = date.getFullYear();
		return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
	}

	/** Gets a value indicating whether the specified date is a holiday. **/
	public static function isHoliday(date: Date): Bool {
		final timestamp = atMidnight(date).getTime();
		return getHolidays(date.getFullYear()).exists(item -> item.getTime() == timestamp);
	}

	/** Gets a value indicating whether the specified date is a working day. **/
	public static function isWorkingDay(date: Date): Bool {
		final dayOfWeek = date.getDay();
		return dayOfWeek >= 1 && dayOfWeek <= 5;
	}

	#if php
	/** Converts the specified PHP date to a Haxe date. **/
	public static function toHaxeDate(date: DateTimeInterface): Date
		return Date.fromString(date.format("Y-m-d H:i:s"));
	#end

	/** Converts the specified date to an ISO 8601 string, using the UTC time zone. **/
	public static function toIsoString(date: Date): String
		return date.delta(date.getTimezoneOffset().minutes()).format("%FT%TZ");

	/** Converts the specified date to an ISO 8601 week. **/
	public static function toIsoWeek(date: Date): String
		return '${Std.string(date.getFullYear()).lpad("0", 4)}-W${Std.string(getWeekOfYear(date)).lpad("0", 2)}';
}
