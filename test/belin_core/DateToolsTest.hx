package belin_core;

import tink.Stringly;
using belin_core.DateTools;

/** Tests the features of the `DateTools` class. **/
@:asserts final class DateToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `atMidnight()` method. **/
	@:variant("2000-01-01 00:00:00", "2000-01-01")
	@:variant("2001-05-03 09:28:56", "2001-05-03")
	@:variant("2010-09-19 13:15:09", "2010-09-19")
	@:variant("2020-12-31 23:59:59", "2020-12-31")
	public function atMidnight(input: String, output: String)
		return assert(Date.fromString(input).atMidnight().getTime() == Date.fromString(output).getTime());

	/** Tests the `getEaster()` method. **/
	@:variant(1901, "1901-04-07")
	@:variant(1942, "1942-04-05")
	@:variant(1986, "1986-03-30")
	@:variant(2021, "2021-04-04")
	@:variant(2046, "2046-03-25")
	public function getEaster(input: Int, output: String)
		return assert(input.getEaster().getTime() == Date.fromString(output).getTime());

	/** Tests the `getQuarter()` method. **/
	@:variant("1901-01-01", 1)
	@:variant("1942-05-11", 2)
	@:variant("1986-08-25", 3)
	@:variant("2023-12-31", 4)
	public function getQuarter(input: String, output: Int)
		return assert(Date.fromString(input).getQuarter() == output);

	/** Tests the `getWeek()` method. **/
	@:variant("2015-12-31", "2015-12-28 00:00:00", "2016-01-03 23:59:59")
	@:variant("2017-07-14", "2017-07-10 00:00:00", "2017-07-16 23:59:59")
	@:variant("2020-05-03", "2020-04-27 00:00:00", "2020-05-03 23:59:59")
	@:variant("2023-01-01", "2022-12-26 00:00:00", "2023-01-01 23:59:59")
	@:variant("2024-02-29", "2024-02-26 00:00:00", "2024-03-03 23:59:59")
	public function getWeek(input: String, start: String, end: String) {
		final week = Date.fromString(input).getWeek();
		asserts.assert(week.a.toString() == start);
		asserts.assert(week.b.toString() == end);
		return asserts.done();
	}

	/** Tests the `getWeekOfYear()` method. **/
	@:variant("2015-12-31", 53)
	@:variant("2017-07-14", 28)
	@:variant("2020-05-03", 18)
	@:variant("2023-01-01", 52)
	@:variant("2024-02-29", 9)
	public function getWeekOfYear(input: String, output: Int)
		return assert(Date.fromString(input).getWeekOfYear() == output);

	/** Tests the `inLeapYear()` method. **/
	@:variant("1600-05-03 09:28:56", true)
	@:variant("1900-09-19 13:15:09", false)
	@:variant("2000-01-01 00:00:00", true)
	@:variant("2022-04-18 09:14:35", false)
	@:variant("2144-08-15 17:08:59", true)
	@:variant("2200-08-15 23:37:12", false)
	public function inLeapYear(input: String, output: Bool)
		return assert(Date.fromString(input).inLeapYear() == output);

	/** Tests the `isHoliday()` method. **/
	@:variant("2021-05-03 09:28:56", false)
	@:variant("2021-09-19 13:15:09", false)
	@:variant("2021-12-31 23:59:59", false)
	@:variant("2021-01-01 00:00:00", true)
	@:variant("2022-04-18 09:14:35", true)
	@:variant("2023-08-15 17:08:59", true)
	public function isHoliday(input: String, output: Bool)
		return assert(Date.fromString(input).isHoliday() == output);

	/** Tests the `isWorkingDay()` method. **/
	@:variant("2022-07-10 00:00:00", false)
	@:variant("2022-12-17 23:59:59", false)
	@:variant("2022-02-25 13:18:44", true)
	@:variant("2022-05-03 09:28:56", true)
	public function isWorkingDay(input: String, output: Bool)
		return assert(Date.fromString(input).isWorkingDay() == output);

	/** Tests the `toIsoString()` method. **/
	@:variant("2000-01-01T00:00:00Z", "2000-01-01T00:00:00Z")
	@:variant("2001-05-03T09:28:56+03:00", "2001-05-03T06:28:56Z")
	@:variant("2010-09-19T13:15:09-03:00", "2010-09-19T16:15:09Z")
	@:variant("2020-12-31T23:59:59+00:00", "2020-12-31T23:59:59Z")
	public function toIsoString(input: Stringly, output: String)
		return assert((input: Date).toIsoString() == output);

	/** Tests the `toIsoWeek()` method. **/
	@:variant("2015-12-31", "2015-W53")
	@:variant("2017-07-14", "2017-W28")
	@:variant("2020-05-03", "2020-W18")
	@:variant("2023-01-01", "2023-W52")
	@:variant("2024-02-29", "2024-W09")
	public function toIsoWeek(input: String, output: String)
		return assert(Date.fromString(input).toIsoWeek() == output);
}
