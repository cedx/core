package belin_core;

/** Tests the features of the `DateRange` enumeration. **/
final class DateRangeTest {

	/** Creates a new test. **/
	public function new() {}

	#if php
	/** Tests the `add()` method. **/
	@:variant(Custom(Date.fromString("1974-05-03 08:45:12"), Date.fromString("2023-11-30 17:30:47")), "PT5M", Custom(Date.fromString("1974-05-03 08:50:12"), Date.fromString("2023-11-30 17:35:47")))
	@:variant(Day(Date.fromString("1974-05-03 08:45:12")), "P1D", Day(Date.fromString("1974-05-04")))
	@:variant(Week(Date.fromString("1974-05-03 08:45:12")), "P2W", Week(Date.fromString("1974-05-17")))
	@:variant(Month(Date.fromString("1974-05-03 08:45:12")), "P3M", Month(Date.fromString("1974-08-03")))
	@:variant(Quarter(Date.fromString("1974-05-03 08:45:12")), "P4M", Quarter(Date.fromString("1974-09-01")))
	@:variant(Year(Date.fromString("1974-05-03 08:45:12")), "P5Y", Year(Date.fromString("1979-05-03")))
	public function add(range: DateRange, duration: String, output: DateRange)
		return assert(range.add(duration).equals(output));
	#end

	/** Tests the `end()` method. **/
	@:variant(Custom(Date.fromString("1974-05-03 08:45:12"), Date.fromString("2023-11-30 17:30:47")), "2023-11-30 17:30:47")
	@:variant(Day(Date.fromString("1974-05-03 08:45:12")), "1974-05-03 23:59:59")
	@:variant(Week(Date.fromString("1974-05-03 08:45:12")), "1974-05-05 23:59:59")
	@:variant(Month(Date.fromString("1974-05-03 08:45:12")), "1974-05-31 23:59:59")
	@:variant(Quarter(Date.fromString("1974-05-03 08:45:12")), "1974-06-30 23:59:59")
	@:variant(Year(Date.fromString("1974-05-03 08:45:12")), "1974-12-31 23:59:59")
	public function end(input: DateRange, output: String)
		return assert(input.end().toString() == output);

	/** Tests the `equals()` method. **/
	@:variant(Custom(Date.fromString("1974-05-03"), Date.fromString("2023-11-30")), Custom(Date.fromString("1974-05-03"), Date.fromString("2023-11-30")), true)
	@:variant(Day(Date.fromString("1974-05-03")), Day(Date.fromString("1974-05-03")), true)
	@:variant(Week(Date.fromString("1974-05-03")), Week(Date.fromString("1974-04-29")), true)
	@:variant(Month(Date.fromString("1974-05-03")), Month(Date.fromString("1974-05-01")), true)
	@:variant(Quarter(Date.fromString("1974-05-03")), Quarter(Date.fromString("1974-04-01")), true)
	@:variant(Year(Date.fromString("1974-05-03")), Year(Date.fromString("1974-01-01")), true)
	@:variant(Custom(Date.fromString("1974-05-03"), Date.fromString("2023-11-30")), Custom(Date.fromString("1975-05-03"), Date.fromString("2022-10-15")), false)
	@:variant(Day(Date.fromString("1974-05-03")), Day(Date.fromString("1974-05-04")), false)
	@:variant(Week(Date.fromString("1974-05-03")), Week(Date.fromString("1974-05-08")), false)
	@:variant(Month(Date.fromString("1974-05-03")), Month(Date.fromString("1974-06-03")), false)
	@:variant(Quarter(Date.fromString("1974-05-03")), Quarter(Date.fromString("1974-09-03")), false)
	@:variant(Year(Date.fromString("1974-05-03")), Year(Date.fromString("1975-05-03")), false)
	public function equals(x: DateRange, y: DateRange, output: Bool)
		return assert(x.equals(y) == output);

	/** Tests the `start()` method. **/
	@:variant(Custom(Date.fromString("1974-05-03 08:45:12"), Date.fromString("2023-11-30 17:30:47")), "1974-05-03 08:45:12")
	@:variant(Day(Date.fromString("1974-05-03 08:45:12")), "1974-05-03 00:00:00")
	@:variant(Week(Date.fromString("1974-05-03 08:45:12")), "1974-04-29 00:00:00")
	@:variant(Month(Date.fromString("1974-05-03 08:45:12")), "1974-05-01 00:00:00")
	@:variant(Quarter(Date.fromString("1974-05-03 08:45:12")), "1974-04-01 00:00:00")
	@:variant(Year(Date.fromString("1974-05-03 08:45:12")), "1974-01-01 00:00:00")
	public function start(input: DateRange, output: String)
		return assert(input.start().toString() == output);

	#if php
	/** Tests the `sub()` method. **/
	@:variant(Custom(Date.fromString("1974-05-03 08:45:12"), Date.fromString("2023-11-30 17:30:47")), "PT5M", Custom(Date.fromString("1974-05-03 08:40:12"), Date.fromString("2023-11-30 17:25:47")))
	@:variant(Day(Date.fromString("1974-05-03 08:45:12")), "P1D", Day(Date.fromString("1974-05-02")))
	@:variant(Week(Date.fromString("1974-05-03 08:45:12")), "P2W", Week(Date.fromString("1974-04-17")))
	@:variant(Month(Date.fromString("1974-05-03 08:45:12")), "P3M", Month(Date.fromString("1974-02-03")))
	@:variant(Quarter(Date.fromString("1974-05-03 08:45:12")), "P4M", Quarter(Date.fromString("1974-01-01")))
	@:variant(Year(Date.fromString("1974-05-03 08:45:12")), "P5Y", Year(Date.fromString("1969-05-03")))
	public function sub(range: DateRange, duration: String, output: DateRange)
		return assert(range.sub(duration).equals(output));
	#end
}
