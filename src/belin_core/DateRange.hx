package belin_core;

#if php
import php.DateInterval;
import php.DateTimeImmutable;
#end

using DateTools;
using belin_core.DateTools;

/** Defines a date range. **/
@:using(belin_core.DateRange.DateRangeTools)
enum DateRange {

	/** A custom range. **/
	Custom(start: Date, end: Date);

	/** The day corresponding to the given date. **/
	Day(date: Date);

	/** The week corresponding to the given date. **/
	Week(date: Date);

	/** The month corresponding to the given date. **/
	Month(date: Date);

	/** The quarter corresponding to the given date. **/
	Quarter(date: Date);

	/** The year corresponding to the given date. **/
	Year(date: Date);
}

/** Provides static extensions for date ranges. **/
private abstract class DateRangeTools {

	#if php
	/** Adds a given ISO 8601 duration to the specified range. **/
	public static function add(range: DateRange, duration: String) {
		function add(date: Date) return new DateTimeImmutable(date.toString()).add(new DateInterval(duration)).toHaxeDate();
		return switch range {
			case Custom(start, end): Custom(add(start), add(end));
			case Day(date): Day(add(date));
			case Week(date): Week(add(date));
			case Month(date): Month(add(date));
			case Quarter(date): Quarter(add(date));
			case Year(date): Year(add(date));
		}
	}
	#end

	/** Returns the end date of the specified range. **/
	public static function end(range: DateRange) return switch range {
		case Custom(_, end): end;
		case Day(date): new Date(date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59);
		case Week(date): date.getWeek().b;
		case Month(date): new Date(date.getFullYear(), date.getMonth(), date.getMonthDays(), 23, 59, 59);
		case Quarter(date):
			final month = new Date(date.getFullYear(), ((date.getQuarter() - 1) * 3) + 2, 1, 0, 0, 0);
			new Date(month.getFullYear(), month.getMonth(), month.getMonthDays(), 23, 59, 59);
		case Year(date): new Date(date.getFullYear(), 11, 31, 23, 59, 59);
	}

	/** Returns a value indicating whether the two specified ranges are equal. **/
	public static function equals(x: DateRange, y: DateRange) return switch [x, y] {
		case [Custom(startX, endX), Custom(startY, endY)]: startX.getTime() == startY.getTime() && endX.getTime() == endY.getTime();
		case _: x.getName() == y.getName() && start(x).getTime() == start(y).getTime();
	}

	/** Returns the start date of the specified range. **/
	public static function start(range: DateRange) return switch range {
		case Custom(start, _): start;
		case Day(date): date.atMidnight();
		case Week(date): date.getWeek().a;
		case Month(date): new Date(date.getFullYear(), date.getMonth(), 1, 0, 0, 0);
		case Quarter(date): new Date(date.getFullYear(), (date.getQuarter() - 1) * 3, 1, 0, 0, 0);
		case Year(date): new Date(date.getFullYear(), 0, 1, 0, 0, 0);
	}

	#if php
	/** Subtracts a given ISO 8601 duration from the specified range. **/
	public static function sub(range: DateRange, duration: String) {
		function sub(date: Date) return new DateTimeImmutable(date.toString()).sub(new DateInterval(duration)).toHaxeDate();
		return switch range {
			case Custom(start, end): Custom(sub(start), sub(end));
			case Day(date): Day(sub(date));
			case Week(date): Week(sub(date));
			case Month(date): Month(sub(date));
			case Quarter(date): Quarter(sub(date));
			case Year(date): Year(sub(date));
		}
	}
	#end
}
