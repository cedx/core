# Represents information relevant to the pagination of data items.
export class Pagination

	# The data limit.
	Object.defineProperty @prototype, "limit",
		get: -> @pageSize

	# The data offset.
	Object.defineProperty @prototype, "offset",
		get: -> (@page - 1) * @pageSize

	# The total number of pages.
	Object.defineProperty @prototype, "pageCount",
		get: -> Math.ceil @totalCount / @pageSize

	# The search parameters corresponding to this object.
	Object.defineProperty @prototype, "searchParams",
		get: -> new URLSearchParams page: @page.toString(), perPage: @pageSize.toString()

	# Creates a new pagination.
	constructor: (options = {}) ->

		# The current page number.
		@page = Math.max 1, options.page ? 1

		# The number of items per page.
		@pageSize = Math.max 1, Math.min 100, options.pageSize ? 25

		# The total number of items.
		@totalCount = Math.max 0, options.totalCount ? 0

	# Creates a new pagination from the HTTP headers of the specified response.
	@fromResponse: (response) -> new @
		page: Number response.headers.get("x-pagination-current-page") or "1"
		pageSize: Number response.headers.get("x-pagination-per-page") or "25"
		totalCount: Number response.headers.get("x-pagination-total-count") or "0"

# A list with information relevant to the pagination of its items.
export class PaginatedList

	# The number of items in this list.
	Object.defineProperty @prototype, "length",
		get: -> @items.length

	# Creates a new paginated list.
	constructor: (options = {}) ->

		# The list items.
		@items = options.items ? []

		# The information relevant to the pagination of the list items.
		@pagination = options.pagination ? new Pagination

	# Creates an empty paginated list.
	@empty: (pageSize) -> new @ pagination: new Pagination pageSize: pageSize

	# Returns a new iterator that allows iterating the items of this list.
	[Symbol.iterator]: ->
		yield item for item from @items
		return
