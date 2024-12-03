# Rounds a floating-point number.
export round = (value, precision = 0) ->
	operand = 10 ** precision
	Math.round(value * operand) / operand
