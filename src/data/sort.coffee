# Represents information relevant to the sorting of data items.
export class Sort

	# The number of attributes.
	Object.defineProperty @prototype, "length",
		get: -> @_attributes.length

	# Creates new sort.
	constructor: (attributes = []) ->

		# The list of attribute/order pairs.
		@_attributes = attributes

	# Creates a new sort from the specified attribute and order.
	@of: (attribute, order = SortOrder.asc) -> new @ [[attribute, order]]

	# Creates a new sort from the specified string.
	@parse: (value) -> new @ (if value then value.split "," else []).map (item) ->
		order = if item.startsWith "-" then SortOrder.desc else SortOrder.asc
		attribute = if order is SortOrder.asc then item else item[1..]
		[attribute, order]

	# Returns a new iterator that allows iterating the entries of this sort.
	[Symbol.iterator]: ->
		yield entry for entry from @_attributes
		return

	# Appends the specified attribute to this sort.
	append: (attribute, order) ->
		@delete attribute
		@_attributes.push [attribute, order]
		this # coffeelint: disable-line = no_this

	# Gets the attribute/order pair at the specified index.
	at: (index) -> @_attributes.at(index) or null

	# Compares the specified objects, according to the current sort attributes.
	compare: (x, y) ->
		same = 0
		for [attribute, order] from @_attributes
			value = switch
				when x[attribute] > y[attribute] then 1
				when x[attribute] < y[attribute] then -1
				else same
			return (if order is SortOrder.asc then value else -value) unless value is same
		same

	# Removes the specified attribute from this sort.
	delete: (attribute) -> @_attributes = @_attributes.filter ([key]) -> key isnt attribute

	# Gets the order associated with the specified attribute.
	get: (attribute) ->
		return order for [key, order] from @_attributes when key is attribute
		null

	# Gets the icon corresponding to the specified attribute.
	getIcon: (attribute) -> switch @get attribute
		when SortOrder.asc then "arrow_upward"
		when SortOrder.desc then "arrow_downward"
		else "swap_vert"

	# Returns a value indicating whether the specified attribute exists in this sort.
	has: (attribute) -> @_attributes.some ([key]) -> key is attribute

	# Gets the index of the specified attribute in the underlying list.
	indexOf: (attribute) ->
		return index for [index, [key]] from @_attributes.entries() when key is attribute
		-1

	# Prepends the specified attribute to this sort.
	prepend: (attribute, order) ->
		@delete attribute
		@_attributes.unshift [attribute, order]
		this # coffeelint: disable-line = no_this

	# Returns a value indicating whether the current sort satisfies the specified conditions.
	satisfies: (conditions) ->
		min = conditions.min ? (-1)
		return @length >= min if min >= 0

		max = conditions.max ? (-1)
		return @length <= max if max >= 0

		attributes = conditions.attributes ? []
		if attributes.length then @_attributes.every ([key]) -> attributes.includes key else yes

	# Sets the order of the specified attribute.
	set: (attribute, order) ->
		for [index, [key]] from @_attributes.entries() then if key is attribute
			@_attributes[index] = [key, order]
			return @
		@append attribute, order

	# Returns a JSON representation of this object.
	toJSON: -> @toString()

	# Converts this sort to an SQL clause.
	toSql: (escape = (identifier) -> identifier) -> @_attributes.map(([attribute, order]) -> "#{escape attribute} #{order}").join ", "

	# Returns a string representation of this object.
	toString: -> @_attributes.map(([attribute, order]) -> "#{if order is SortOrder.desc then "-" else ""}#{attribute}").join ","

# Specifies the order of a sort parameter.
export SortOrder = Object.freeze

	# The sort is ascending.
	asc: "ASC"

	# The sort is descending.
	desc: "DESC"
