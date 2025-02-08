import {Pagination} from "@cedx/core/data/pagination.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link Pagination} class.
 */
describe("Pagination", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("limit", () => {
		it("should return the same value as the page size, with a minimum of 1 and a maxiumum of 100", () => {
			equal(new Pagination({pageSize: 0}).limit, 1);
			equal(new Pagination({pageSize: 25}).limit, 25);
			equal(new Pagination({pageSize: 123}).limit, 100);
		});
	});

	describe("offset", () => {
		it("should return the page size multiplied by the page index minus one", () => {
			equal(new Pagination({page: 1}).offset, 0);
			equal(new Pagination({page: 5, pageSize: 25}).offset, 100);
			equal(new Pagination({page: 123, pageSize: 5}).offset, 610);
		});
	});

	describe("pageCount", () => {
		it("should return the total count divided by the page size rounded up", () => {
			equal(new Pagination({totalCount: 0}).pageCount, 0);
			equal(new Pagination({pageSize: 1, totalCount: 123}).pageCount, 123);
			equal(new Pagination({pageSize: 10, totalCount: 25}).pageCount, 3);
		});
	});

	describe("searchParams", () => {
		it("should include a `page` parameter", () => {
			const {searchParams} = new Pagination;
			assert.isTrue(searchParams.has("page"));
			equal(searchParams.get("page"), "1");

			equal(new Pagination({page: -5}).searchParams.get("page"), "1");
			equal(new Pagination({page: 123}).searchParams.get("page"), "123");
		});

		it("should include a `perPage` parameter", () => {
			const {searchParams} = new Pagination;
			assert.isTrue(searchParams.has("perPage"));
			equal(searchParams.get("perPage"), "25");

			equal(new Pagination({pageSize: 66}).searchParams.get("perPage"), "66");
			equal(new Pagination({pageSize: 456}).searchParams.get("perPage"), "100");
		});
	});

	describe("fromResponse()", () => {
		it("should create an instance initialized from the response headers", () => {
			const pagination = Pagination.fromResponse(new Response(null, {headers: {
				"x-pagination-current-page": "123",
				"x-pagination-per-page": "33",
				"x-pagination-total-count": "666"
			}}));

			equal(pagination.page, 123);
			equal(pagination.pageSize, 33);
			equal(pagination.totalCount, 666);
		});
	});
});
