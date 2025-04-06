import {FileCache} from "@cedx/core/Caching/FileCache.js";
import {Duration} from "@cedx/core/Util/Duration.js";
import {assert} from "chai";
import {mkdir, rm} from "node:fs/promises";
import {setTimeout} from "node:timers/promises";

/**
 * Tests the features of the {@link FileCache} class.
 */
describe("FileCache", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	const cache = new FileCache("var/cache");
	beforeEach(async () => {
		await rm(cache.path, {force: true, recursive: true});
		await mkdir("var/cache");
	});

	describe("clear()", () => {
		it("should remove all cache entries", async () => {
			await cache.set("foo", "bar");
			assert.isTrue(await cache.has("foo"));
			await cache.clear();
			assert.isFalse(await cache.has("foo"));
		});
	});

	describe("delete()", () => {
		it("should properly remove the specified key", async () => {
			await cache.set("foo", "bar");
			assert.isTrue(await cache.has("foo"));
			await cache.delete("foo");
			assert.isFalse(await cache.has("foo"));
		});
	});

	describe("get()", () => {
		it("should return `null` if the specified key does not exist", async () =>
			equal(await cache.get("foo"), null));

		it("should return the cached value if the specified key exists", async () => {
			await cache.set("foo", "bar");
			equal(await cache.get("foo"), "bar");
		});

		it("should return `null` if the specified key has expired", async function() {
			this.timeout(3 * Duration.second);
			await cache.set("foo", "bar", 1);
			await setTimeout(1.5 * Duration.second);
			equal(await cache.get("foo"), null);
		});
	});

	describe("has()", () => {
		it("should return `false` if the specified key does not exist", async () =>
			assert.isFalse(await cache.has("foo")));

		it("should return `true` if the specified key exists", async () => {
			await cache.set("foo", "bar");
			assert.isTrue(await cache.has("foo"));
		});

		it("should return `false` if the specified key has expired", async function() {
			this.timeout(3 * Duration.second);
			await cache.set("foo", "bar", 1);
			await setTimeout(1.5 * Duration.second);
			assert.isFalse(await cache.has("foo"));
		});
	});

	describe("set()", () => {
		it("should properly set the cache entry", async () => {
			equal(await cache.get("foo"), null);
			await cache.set("foo", "bar");
			equal(await cache.get("foo"), "bar");
		});
	});
});
