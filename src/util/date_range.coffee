import {atMidnight, daysInMonth, getQuarter} from "./date.js"
import {Duration} from "./duration.js"

# Defines a date range.
export class DateRange

	# Creates a new date range.
	constructor: (start, end, type = DateRangeType.custom) ->

		# The end date.
		@end = end

		# The start date.
		@start = start

		# The range type.
		@type = type

	# Creates a new date range from the specified JSON object.
	@fromJson: (json) ->
		start = new Date if typeof json.start is "string" then json.start else Date.now()
		end = new Date if typeof json.end is "string" then json.end else Date.now()
		type = if Object.values(DateRangeType).includes(json.type) then json.type else DateRangeType.custom
		new @ start, end, type

	# Creates a date range corresponding to the day including the specified date.
	@day: (date) ->
		start = atMidnight date
		end = new Date date.getFullYear(), date.getMonth(), date.getDate(), 23, 59, 59
		new @ start, end, DateRangeType.day

	# Creates a date range corresponding to the month including the specified date.
	@month: (date) ->
		start = new Date date.getFullYear(), date.getMonth(), 1
		end = new Date date.getFullYear(), date.getMonth(), daysInMonth(date), 23, 59, 59
		new @ start, end, DateRangeType.month

	# Creates a date range corresponding to the quarter including the specified date.
	@quarter: (date) ->
		start = new Date date.getFullYear(), firstMonth = (getQuarter(date) * 3) - 3, 1
		end = new Date date.getFullYear(), lastMonth = firstMonth + 2, daysInMonth(new Date(date.getFullYear(), lastMonth, 1)), 23, 59, 59
		new @ start, end, DateRangeType.quarter

	# Creates a date range corresponding to the week including the specified date.
	@week: (date) ->
		delta = -((date.getDay() + 6) % 7)
		sunday = new Date date.getTime() + ((delta + 6) * Duration.day)
		sunday.setHours 23, 59, 59
		new @ atMidnight(new Date(date.getTime() + (delta * Duration.day))), sunday, DateRangeType.week

	# Creates a date range corresponding to the year including the specified date.
	@year: (date) ->
		start = new Date date.getFullYear(), 0, 1
		end = new Date date.getFullYear(), 11, 31, 23, 59, 59
		new @ start, end, DateRangeType.year

	# Returns a value indicating whether this date range is equal to the specified date range.
	equals: (other) -> @start.getTime() is other.start.getTime() and @end.getTime() is other.end.getTime()

# Defines the type of a date range.
export DateRangeType = Object.freeze

	# A custom date range.
	custom: ""

	# A whole day.
	day: "P1D"

	# A whole week.
	week: "P1W"

	# A whole month.
	month: "P1M"

	# A whole quarter.
	quarter: "P3M"

	# A whole year.
	year: "P1Y"
