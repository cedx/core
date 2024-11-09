import {Duration} from "./duration.js"

# Returns the date at midnight corresponding to the specified date.
export atMidnight = (date) -> new Date date.getFullYear(), date.getMonth(), date.getDate()

# Gets the number of days in the month of the specified date.
export daysInMonth = (date) -> new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate()

# Gets the date of Easter for a given year.
export getEaster = (year = new Date().getFullYear()) ->
	n = year % 19
	c = Math.trunc(year / 100)
	u = year % 100
	e = ((19 * n) + c - Math.trunc(c / 4) - Math.trunc((c - Math.trunc((c + 8) / 25) + 1) / 3) + 15) % 30
	l = ((2 * (c % 4)) + (2 * Math.trunc(u / 4)) - e - (u % 4) + 32) % 7
	h = Math.trunc((n + (11 * e) + (22 * l)) / 451)
	result = e + l - (7 * h) + 114
	new Date year, Math.trunc(result / 31) - 1, (result % 31) + 1

# Gets the list of holidays for a given year.
export getHolidays = (year = new Date().getFullYear()) ->
	# Fixed holidays.
	holidays = []
	holidays.push new Date year, 0, 1 # New year.
	holidays.push new Date year, 4, 1 # Labor day.
	holidays.push new Date year, 4, 8 # Armistice (1945).
	holidays.push new Date year, 6, 14 # National holiday.
	holidays.push new Date year, 7, 15 # Assumption.
	holidays.push new Date year, 10, 1 # Toussaint.
	holidays.push new Date year, 10, 11 # Armistice (1918).
	holidays.push new Date year, 11, 25 # Christmas.

	# Holidays depending on Easter.
	easter = getEaster(year)
	holidays.push new Date easter.getTime() + Duration.day # Easter monday.
	holidays.push new Date easter.getTime() + (39 * Duration.day) # Ascension thursday.
	holidays.push new Date easter.getTime() + (50 * Duration.day) # Pentecost monday.
	holidays

# Gets the quarter corresponding to the specified date.
export getQuarter = (date) -> Math.ceil (date.getMonth() + 1) / 3

# Gets the week number corresponding to the specified date.
export getWeekOfYear = (date) ->
	thursday = new Date date.getFullYear(), date.getMonth(), date.getDate() + 3 - ((date.getDay() + 6) % 7)
	firstWeek = new Date thursday.getFullYear(), 0, 4
	1 + Math.round (((thursday.getTime() - firstWeek.getTime()) / Duration.day) - 3 + ((firstWeek.getDay() + 6) % 7)) / 7

# Returns a value indicating whether the specified date is in a leap year.
export inLeapYear = (date) ->
	year = date.getFullYear()
	year % 4 is 0 and (year % 100 isnt 0 or year % 400 is 0)

# Returns a value indicating whether the specified date is a holiday.
export isHoliday = (date) ->
	timestamp = atMidnight(date).getTime()
	getHolidays(date.getFullYear()).some (holiday) -> holiday.getTime() is timestamp

# Returns a value indicating whether the specified date is a working day.
export isWorkingDay = (date) -> 1 <= date.getDay() <= 5

# Converts the specified date to an ISO 8601 week.
export toIsoWeek = (date) -> "#{date.getFullYear().toString().padStart 4, "0"}-W#{getWeekOfYear(date).toString().padStart 2, "0"}"

# Converts the specified date to the "YYYY-MM-DD HH:MM:SS" format.
export toYmdHms = (date, options = {}) ->
	padStart = (number, length = 2) -> number.toString().padStart length, "0"
	parts = []
	parts.push [padStart(date.getFullYear(), 4), padStart(date.getMonth() + 1), padStart(date.getDate())].join "-" unless options.excludeDate
	parts.push [date.getHours(), date.getMinutes(), date.getSeconds()].map((item) -> padStart item).join ":" unless options.excludeTime
	parts.join options.separator ? " "
