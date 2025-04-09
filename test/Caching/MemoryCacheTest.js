import {MemoryCache} from "@cedx/core/Caching/MemoryCache.js";
import {Duration} from "@cedx/core/Util/Duration.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link MemoryCache} class.
 */
describe("MemoryCache", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("clear()", () => {
		const cache = new MemoryCache;

		it("should remove all cache entries", async () => {
			await cache.set("foo", "bar");
			assert.isTrue(await cache.has("foo"));
			await cache.clear();
			assert.isFalse(await cache.has("foo"));
		});
	});

	describe("delete()", () => {
		const cache = new MemoryCache;

		it("should properly remove the specified key", async () => {
			await cache.set("foo", "bar");
			assert.isTrue(await cache.has("foo"));
			await cache.delete("foo");
			assert.isFalse(await cache.has("foo"));
		});
	});

	describe("get()", () => {
		const cache = new MemoryCache;

		it("should return `null` if the specified key does not exist", async () =>
			equal(await cache.get("foo"), null));

		it("should return the cached value if the specified key exists", async () => {
			await cache.set("foo", "bar");
			equal(await cache.get("foo"), "bar");
		});

		it("should return `null` if the specified key has expired", async function() {
			this.timeout(3 * Duration.Second);
			await cache.set("foo", "bar", 1);
			await wait(1.5 * Duration.Second);
			equal(await cache.get("foo"), null);
		});
	});

	describe("has()", () => {
		const cache = new MemoryCache;

		it("should return `false` if the specified key does not exist", async () =>
			assert.isFalse(await cache.has("foo")));

		it("should return `true` if the specified key exists", async () => {
			await cache.set("foo", "bar");
			assert.isTrue(await cache.has("foo"));
		});

		it("should return `false` if the specified key has expired", async function() {
			this.timeout(3 * Duration.Second);
			await cache.set("foo", "bar", 1);
			await wait(1.5 * Duration.Second);
			assert.isFalse(await cache.has("foo"));
		});
	});

	describe("set()", () => {
		const cache = new MemoryCache;

		it("should properly set the cache entry", async () => {
			equal(await cache.get("foo"), null);
			await cache.set("foo", "bar");
			equal(await cache.get("foo"), "bar");
		});
	});
});

/**
 * Delays the program execution for the given number of milliseconds.
 * @param {number} milliseconds The halt time in milliseconds.
 * @returns {Promise<void>} Resolves when the delay has elapsed.
 */
function wait(milliseconds) {
	return new Promise(resolve => setTimeout(resolve, milliseconds));
}
