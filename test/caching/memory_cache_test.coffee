import {MemoryCache} from "@cedx/core/caching/memory_cache.js"
import {Duration} from "@cedx/core/util/duration.js"
import {assert} from "chai"

# Delays the program execution for the given number of milliseconds.
wait = (milliseconds) -> new Promise (resolve) -> setTimeout resolve, milliseconds

# Tests the features of the `MemoryCache` class.
describe "MemoryCache", ->
	{equal, isFalse, isTrue} = assert

	describe "clear()", ->
		cache = new MemoryCache
		it "should remove all cache entries", ->
			await cache.set "foo", "bar"
			isTrue await cache.has "foo"
			await cache.clear()
			isFalse await cache.has "foo"

	describe "delete()", ->
		cache = new MemoryCache
		it "should properly remove the specified key", ->
			await cache.set "foo", "bar"
			isTrue await cache.has "foo"
			await cache.delete "foo"
			isFalse await cache.has "foo"

	describe "get()", ->
		cache = new MemoryCache

		it "should return `null` if the specified key does not exist", ->
			equal await cache.get("foo"), null

		it "should return the cached value if the specified key exists", ->
			await cache.set "foo", "bar"
			equal await cache.get("foo"), "bar"

		it "should return `null` if the specified key has expired", ->
			@timeout 3 * Duration.second
			await cache.set "foo", "bar", 1
			await wait 1.5 * Duration.second
			equal await cache.get("foo"), null

	describe "has()", ->
		cache = new MemoryCache

		it "should return `false` if the specified key does not exist", ->
			isFalse await cache.has "foo"

		it "should return `true` if the specified key exists", ->
			await cache.set "foo", "bar"
			isTrue await cache.has "foo"

		it "should return `false` if the specified key has expired", ->
			@timeout 3 * Duration.second
			await cache.set "foo", "bar", 1
			await wait 1.5 * Duration.second
			isFalse await cache.has "foo"

	describe "set()", ->
		cache = new MemoryCache
		it "should properly set the cache entry", ->
			equal await cache.get("foo"), null
			await cache.set "foo", "bar"
			equal await cache.get("foo"), "bar"
