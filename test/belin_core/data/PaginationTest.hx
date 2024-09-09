package belin_core.data;

/** Tests the features of the `Pagination` class. **/
final class PaginationTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `limit` property. **/
	@:variant(0, 1)
	@:variant(25, 25)
	@:variant(123, 100)
	public function limit(input: Int, output: Int)
		return assert(new Pagination({pageSize: input}).limit == output);

	/** Tests the `offset` property. **/
	@:variant(1, null, 0)
	@:variant(5, 25, 100)
	@:variant(123, 5, 610)
	public function offset(page: Int, pageSize: Null<Int>, output: Int)
		return assert(new Pagination({page: page, pageSize: pageSize}).offset == output);

	/** Tests the `pageCount` property. **/
	@:variant(0, null, 0)
	@:variant(123, 1, 123)
	@:variant(25, 10, 3)
	public function pageCount(totalCount: Int, pageSize: Null<Int>, output: Int)
		return assert(new Pagination({pageSize: pageSize, totalCount: totalCount}).pageCount == output);
}
