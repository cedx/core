import {hash} from "node:crypto"
import {readdir, readFile, stat, unlink, utimes, writeFile} from "node:fs/promises"
import {join} from "node:path"
import {Duration} from "../util/duration.js"

# Implements a cache using files.
export class FileCache

	# Creates a new file cache.
	constructor: (path, options = {}) ->

		# The path of the directory to store cache files.
		@path = path

		# The default duration in seconds before a cache entry will expire.
		@_defaultDuration = options.defaultDuration ? 0

		# The cache file suffix.
		@_fileSuffix = options.fileSuffix ? ".json"

		# A string prefixed to every cache key so that it is unique globally in the whole cache storage.
		@_keyPrefix = options.keyPrefix ? ""

		# The instance used to serialize and unserialize cached data.
		@_serializer = options.serializer ? serialize: JSON.stringify, unserialize: JSON.parse

	# Removes all entries from this cache.
	clear: -> await unlink join @path, file for file from (await readdir @path).filter (item) => item.endsWith @_fileSuffix

	# Removes the value associated with the specified key.
	delete: (key) -> unlink @_getFilePath key

	# Gets the value associated with the specified key.
	get: (key) -> if await @_cacheExpired key then null else @_serializer.unserialize await readFile @_getFilePath(key), "utf8"

	# Gets a value indicating whether this cache contains the specified key.
	has: (key) -> not (await @_cacheExpired key)

	# Associates a given value with the specified key.
	set: (key, value, duration = -1) ->
		duration = @_defaultDuration if duration < 0
		file = @_getFilePath key
		await writeFile file, @_serializer.serialize value
		await utimes file, new Date, (Date.now() / Duration.second) + (if duration > 0 then duration else 365 * Duration.day)
		this # coffeelint: disable-line = no_this

	# Builds a normalized cache key from the given key.
	_buildKey: (key) -> hash "md5", "#{@_keyPrefix}#{key}"

	# Returns a value indicating whether the cached data with the specified key has expired.
	_cacheExpired: (key) ->
		try (await stat @_getFilePath(key)).mtimeMs <= Date.now()
		catch then yes

	# Returns the path of the cache file corresponding to the given key.
	_getFilePath: (key) -> join @path, "#{@_buildKey key}#{@_fileSuffix}"
