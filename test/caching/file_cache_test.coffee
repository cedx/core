import {FileCache} from "@cedx/core/caching/file_cache.js"
import {Duration} from "@cedx/core/util/duration.js"
import {assert} from "chai"
import {mkdir, rm} from "node:fs/promises"
import {scheduler} from "node:timers/promises"

# Tests the features of the `FileCache` class.
describe "FileCache", ->
	{equal, isFalse, isTrue} = assert

	cache = new FileCache "var/cache"
	beforeEach ->
		await rm cache.path, force: yes, recursive: yes
		await mkdir "var/cache"

	describe "clear()", ->
		it "should remove all cache entries", ->
			await cache.set "foo", "bar"
			isTrue await cache.has "foo"
			await cache.clear()
			isFalse await cache.has "foo"

	describe "delete()", ->
		it "should properly remove the specified key", ->
			await cache.set "foo", "bar"
			isTrue await cache.has "foo"
			await cache.delete "foo"
			isFalse await cache.has "foo"

	describe "get()", ->
		it "should return `null` if the specified key does not exist", ->
			equal await cache.get("foo"), null

		it "should return the cached value if the specified key exists", ->
			await cache.set "foo", "bar"
			equal await cache.get("foo"), "bar"

		it "should return `null` if the specified key has expired", ->
			@timeout 3 * Duration.second
			await cache.set "foo", "bar", 1
			await scheduler.wait 1.5 * Duration.second
			equal await cache.get("foo"), null

	describe "has()", ->
		it "should return `false` if the specified key does not exist", ->
			isFalse await cache.has "foo"

		it "should return `true` if the specified key exists", ->
			await cache.set "foo", "bar"
			isTrue await cache.has "foo"

		it "should return `false` if the specified key has expired", ->
			@timeout 3 * Duration.second
			await cache.set "foo", "bar", 1
			await scheduler.wait 1.5 * Duration.second
			isFalse await cache.has "foo"

	describe "set()", ->
		it "should properly set the cache entry", ->
			equal await cache.get("foo"), null
			await cache.set "foo", "bar"
			equal await cache.get("foo"), "bar"
