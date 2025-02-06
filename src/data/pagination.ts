/**
 * Represents information relevant to the pagination of data items.
 */
export class Pagination {

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

	/**
	 * Creates a new pagination.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(options: PaginationOptions = {}) {
		this.page = Math.max(1, options.page ?? 1);
		this.pageSize = Math.max(1, Math.min(100, options.pageSize ?? 25));
		this.totalCount = Math.max(0, options.totalCount ?? 0);
	}

	/**
	 * The data limit.
	 */
	get limit(): number {
		return this.pageSize;
	}

	/**
	 * The data offset.
	 */
	get offset(): number {
		return (this.page - 1) * this.pageSize;
	}

	/**
	 * The total number of pages.
	 */
	get pageCount(): number {
		return Math.ceil(this.totalCount / this.pageSize);
	}

	/**
	 * The search parameters corresponding to this object.
	 */
	get searchParams(): URLSearchParams {
		return new URLSearchParams({page: this.page.toString(), perPage: this.pageSize.toString()});
	}

	/**
	 * Creates a new pagination from the HTTP headers of the specified response.
	 * @param response A server response.
	 * @returns The pagination corresponding to the HTTP headers of the specified response.
	 */
	static fromResponse(response: Response): Pagination {
		return new this({
			page: Number(response.headers.get("x-pagination-current-page") ?? "1"),
			pageSize: Number(response.headers.get("x-pagination-per-page") ?? "25"),
			totalCount: Number(response.headers.get("x-pagination-total-count") ?? "0")
		});
	}
}

/**
 * Defines the options of a {@link Pagination} instance.
 */
export type PaginationOptions = Partial<Pick<Pagination, "page"|"pageSize"|"totalCount">>;

/**
 * A list with information relevant to the pagination of its items.
 */
export class PaginatedList<T> {

	/**
	 * The list items.
	 */
	items: T[];

	/**
	 * The information relevant to the pagination of the list items.
	 */
	pagination: Pagination;

	/**
	 * Creates a new paginated list.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(options: PaginatedListOptions<T> = {}) {
		this.items = options.items ?? [];
		this.pagination = options.pagination ?? new Pagination;
	}

	/**
	 * The number of items in this list.
	 */
	get length(): number {
		return this.items.length;
	}

	/**
	 * Creates an empty paginated list.
	 * @param pageSize The number of items per page.
	 * @returns An empty paginated list with the specified number of items per page.
	 */
	static empty<T>(pageSize: number): PaginatedList<T> {
		return new this({pagination: new Pagination({pageSize})});
	}

	/**
	 * Returns a new iterator that allows iterating the items of this list.
	 * @returns An iterator over the items of this list.
	 */
	*[Symbol.iterator](): IterableIterator<T> {
		for (const item of this.items) yield item;
	}
}

/**
 * Defines the options of a {@link PaginatedList} instance.
 */
export type PaginatedListOptions<T> = Partial<Pick<PaginatedList<T>, "items"|"pagination">>;
