# Defines the access level associated to a feature or a permission.
export AccessLevel = Object.freeze

	# The read access.
	read: "read"

	# The write access.
	write: "write"

	# The administrator access.
	admin: "admin"

# Returns a value indicating whether the first access level is greater than the second.
export greaterThan = (x, y) -> switch x
	when AccessLevel.write then y is AccessLevel.read
	when AccessLevel.admin then y is AccessLevel.read or y is AccessLevel.write
	else no

# Returns a value indicating whether the first access level is greater than or equal to the second.
export greaterThanOrEqual = (x, y) -> switch x
	when AccessLevel.read then y is AccessLevel.read
	when AccessLevel.write then y is AccessLevel.read or y is AccessLevel.write
	else yes

# Returns a value indicating whether the first access level is less than the second.
export lessThan = (x, y) -> not greaterThanOrEqual x, y

# Returns a value indicating whether the first access level is less than or equal to the second.
export lessThanOrEqual = (x, y) -> not greaterThan x, y
