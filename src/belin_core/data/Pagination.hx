package belin_core.data;

import coconut.data.Model;

/** Represents information relevant to the pagination of data items. **/
@:jsonParse(json -> new core.data.Pagination(json))
@:jsonStringify(pagination -> {
	page: pagination.page,
	pageSize: pagination.pageSize,
	totalCount: pagination.totalCount
})
final class Pagination implements Model {

	/** The limit of the data. **/
	@:computed var limit: Int = pageSize;

	/** The offset of the data. **/
	@:computed var offset: Int = (page - 1) * pageSize;

	/** The current page number. **/
	@:editable var page: Int = @byDefault 1;

	/** The number of pages. **/
	@:computed var pageCount: Int = pageSize > 0 ? Math.ceil(totalCount / pageSize) : 0;

	/** The number of items per page. **/
	@:editable var pageSize: Int = @byDefault 25;

	/** The total number of items. **/
	@:editable var totalCount: Int = @byDefault 0;

	/** Creates a new pagination. **/
	public function new(?options: PaginationOptions) this = {
		page: Std.int(Math.max(1, options?.page ?? 1)),
		pageSize: Std.int(Math.max(1, Math.min(options?.pageSize ?? 25, 100))),
		totalCount: Std.int(Math.max(0, options?.totalCount ?? 0))
	};
}

/** Defines the options of a `Pagination` instance. **/
typedef PaginationOptions = {

	/** The current page number. **/
	var ?page: Int;

	/** The number of items per page. **/
	var ?pageSize: Int;

	/** The total number of items. **/
	var ?totalCount: Int;
}
