# Returns a value indicating whether the specified number is a numeric identifier, i.e. a positive integer greater than zero.
export isIdentifier = (value) ->
	Number.isInteger(value) and value > 0

# Rounds a floating-point number.
export round = (value, precision = 0) ->
	operand = 10 ** precision
	Math.round(value * operand) / operand
