import {DateRange, DateRangeType} from "@cedx/core/Util/DateRange.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link DateRange} class.
 */
describe("DateRange", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("end", () => {
		it("should return the last moment of the date range", () => {
			const date = new Date("1974-05-03 08:45:12");
			equal(new DateRange(date, new Date("2023-11-30 17:30:47")).end.getTime(), new Date("2023-11-30 17:30:47").getTime());
			equal(DateRange.day(date).end.getTime(), new Date("1974-05-03 23:59:59").getTime());
			equal(DateRange.week(date).end.getTime(), new Date("1974-05-05 23:59:59").getTime());
			equal(DateRange.month(date).end.getTime(), new Date("1974-05-31 23:59:59").getTime());
			equal(DateRange.quarter(date).end.getTime(), new Date("1974-06-30 23:59:59").getTime());
			equal(DateRange.year(date).end.getTime(), new Date("1974-12-31 23:59:59").getTime());
		});
	});

	describe("start", () => {
		it("should return the first moment of the date range", () => {
			const date = new Date("1974-05-03 08:45:12");
			equal(new DateRange(date, new Date("2023-11-30 17:30:47")).start.getTime(), date.getTime());
			equal(DateRange.day(date).start.getTime(), new Date("1974-05-03 00:00:00").getTime());
			equal(DateRange.week(date).start.getTime(), new Date("1974-04-29 00:00:00").getTime());
			equal(DateRange.month(date).start.getTime(), new Date("1974-05-01 00:00:00").getTime());
			equal(DateRange.quarter(date).start.getTime(), new Date("1974-04-01 00:00:00").getTime());
			equal(DateRange.year(date).start.getTime(), new Date("1974-01-01 00:00:00").getTime());
		});
	});

	describe("type", () => {
		it("should return the type of a date range", () => {
			const date = new Date("1974-05-03 08:45:12");
			equal(new DateRange(date, new Date("2023-11-30 17:30:47")).type, DateRangeType.Custom);
			equal(DateRange.day(date).type, DateRangeType.Day);
			equal(DateRange.week(date).type, DateRangeType.Week);
			equal(DateRange.month(date).type, DateRangeType.Month);
			equal(DateRange.quarter(date).type, DateRangeType.Quarter);
			equal(DateRange.year(date).type, DateRangeType.Year);
		});
	});

	describe("equals()", () => {
		it("should return `true` if the two date ranges are equal", () => {
			const date = new Date("1974-05-03 00:00:00");
			assert.isTrue(new DateRange(date, new Date("2023-11-30 12:30:15")).equals(new DateRange(date, new Date("2023-11-30 12:30:15"))));
			assert.isTrue(DateRange.day(date).equals(DateRange.day(date)));
			assert.isTrue(DateRange.week(date).equals(DateRange.week(new Date("1974-04-29 00:00:00"))));
			assert.isTrue(DateRange.month(date).equals(DateRange.month(new Date("1974-05-01 00:00:00"))));
			assert.isTrue(DateRange.quarter(date).equals(DateRange.quarter(new Date("1974-04-01 00:00:00"))));
			assert.isTrue(DateRange.year(date).equals(DateRange.year(new Date("1974-01-01 00:00:00"))));
		});

		it("should return `false` if the two date ranges are not equal", () => {
			const date = new Date("1974-05-03 00:00:00");
			assert.isFalse(new DateRange(date, new Date("2023-11-30 12:30:15")).equals(new DateRange(date, new Date("2022-10-15 12:30:15"))));
			assert.isFalse(DateRange.day(date).equals(DateRange.day(new Date("1974-05-04 00:00:00"))));
			assert.isFalse(DateRange.week(date).equals(DateRange.week(new Date("1974-05-08 00:00:00"))));
			assert.isFalse(DateRange.month(date).equals(DateRange.month(new Date("1974-06-03 00:00:00"))));
			assert.isFalse(DateRange.quarter(date).equals(DateRange.quarter(new Date("1974-09-03 00:00:00"))));
			assert.isFalse(DateRange.year(date).equals(DateRange.year(new Date("1975-05-03 00:00:00"))));
		});
	});

	describe("week()", () => {
		it("should return the week encompassing the specified date", () => {
			let range = DateRange.week(new Date("2015-12-31 00:00:00"));
			equal(range.start.getTime(), new Date("2015-12-28 00:00:00").getTime());
			equal(range.end.getTime(), new Date("2016-01-03 23:59:59").getTime());

			range = DateRange.week(new Date("2017-07-14 00:00:00"));
			equal(range.start.getTime(), new Date("2017-07-10 00:00:00").getTime());
			equal(range.end.getTime(), new Date("2017-07-16 23:59:59").getTime());

			range = DateRange.week(new Date("2020-05-03 00:00:00"));
			equal(range.start.getTime(), new Date("2020-04-27 00:00:00").getTime());
			equal(range.end.getTime(), new Date("2020-05-03 23:59:59").getTime());

			range = DateRange.week(new Date("2023-01-01 00:00:00"));
			equal(range.start.getTime(), new Date("2022-12-26 00:00:00").getTime());
			equal(range.end.getTime(), new Date("2023-01-01 23:59:59").getTime());

			range = DateRange.week(new Date("2024-02-29 00:00:00"));
			equal(range.start.getTime(), new Date("2024-02-26 00:00:00").getTime());
			equal(range.end.getTime(), new Date("2024-03-03 23:59:59").getTime());
		});
	});
});
