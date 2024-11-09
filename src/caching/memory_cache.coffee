import {Duration} from "../util/duration.js"

# Implements an in-memory cache.
export class MemoryCache

	# Creates a new memory service.
	constructor: (options = {}) ->

		# The cache data.
		@_cache = new Map

		# The default duration in seconds before a cache entry will expire.
		@_defaultDuration = options.defaultDuration ? 0

		# A string prefixed to every cache key so that it is unique globally in the whole cache storage.
		@_keyPrefix = options.keyPrefix ? ""

		# The instance used to serialize and unserialize cached data.
		@_serializer = options.serializer ? serialize: JSON.stringify, unserialize: JSON.parse

	# Removes all entries from this cache.
	clear: ->
		@_cache.clear()
		Promise.resolve()

	# Removes the value associated with the specified key.
	delete: (key) ->
		@_cache.delete @_buildKey key
		Promise.resolve()

	# Gets the value associated with the specified key.
	get: (key) ->
		value = if @_cacheExpired key then null else @_serializer.unserialize @_cache.get(@_buildKey key).value
		Promise.resolve value

	# Gets a value indicating whether this cache contains the specified key.
	has: (key) -> Promise.resolve not @_cacheExpired key

	# Associates a given value with the specified key.
	set: (key, value, duration = -1) ->
		duration = @_defaultDuration if duration < 0
		@_cache.set @_buildKey(key),
			expires: if duration > 0 then new Date(Date.now() + (duration * Duration.second)) else null
			value: @_serializer.serialize value
		Promise.resolve @

	# Builds a normalized cache key from the given key.
	_buildKey: (key) -> "#{@_keyPrefix}#{key}"

	# Returns a value indicating whether the cached data with the specified key has expired.
	_cacheExpired: (key) ->
		prefixedKey = @_buildKey key
		return yes unless @_cache.has prefixedKey

		{expires} = @_cache.get prefixedKey
		return no if not expires or expires.getTime() > Date.now()

		@_cache.delete prefixedKey
		yes
