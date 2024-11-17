/**
 * Represents information relevant to the pagination of data items.
 */
export class Pagination {

	/**
	 * The data limit.
	 */
	readonly limit: number;

	/**
	 * The data offset.
	 */
	readonly offset: number;

	/**
	 * The current page number.
	 */
	page: number;

	/**
	 * The total number of pages.
	 */
	readonly pageCount: number;

	/**
	 * The number of items per page.
	 */
	pageSize: number;

	/**
	 * The search parameters corresponding to this object.
	 */
	readonly searchParams: URLSearchParams;

	/**
	 * The total number of items.
	 */
	totalCount: number;

	/**
	 * Creates a new pagination.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(options?: PaginationOptions);

	/**
	 * Creates a new pagination from the HTTP headers of the specified response.
	 * @param response A server response.
	 * @returns The pagination corresponding to the HTTP headers of the specified response.
	 */
	static fromResponse(response: Response): Pagination;
}

/**
 * Defines the options of a {@link Pagination} instance.
 */
export type PaginationOptions = Partial<{

	/**
	 * The current page number.
	 */
	page: number;

	/**
	 * The number of items per page.
	 */
	pageSize: number;

	/**
	 * The total number of items.
	 */
	totalCount: number;
}>;

/**
 * A list with information relevant to the pagination of its items.
 */
export class PaginatedList<T> {

	/**
	 * The list items.
	 */
	items: Array<T>;

	/**
	 * The number of items in this list.
	 */
	readonly length: number;

	/**
	 * The information relevant to the pagination of the list items.
	 */
	pagination: Pagination;

	/**
	 * Creates a new paginated list.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(options?: PaginatedListOptions<T>);

	/**
	 * Creates an empty paginated list.
	 * @param pageSize The number of items per page.
	 * @returns An empty paginated list with the specified number of items per page.
	 */
	static empty<T>(pageSize: number): PaginatedList<T>;

	/**
	 * Returns a new iterator that allows iterating the items of this list.
	 * @returns An iterator over the items of this list.
	 */
	[Symbol.iterator](): IterableIterator<T>;
}

/**
 * Defines the options of a {@link PaginatedList} instance.
 */
export type PaginatedListOptions<T> = Partial<{

	/**
	 * The list items.
	 */
	items: Array<T>;

	/**
	 * The information relevant to the pagination of the list items.
	 */
	pagination: Pagination;
}>;
