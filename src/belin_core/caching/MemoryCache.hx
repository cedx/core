package belin_core.caching;

import belin_core.caching.Cache.CacheOptions;
import belin_core.caching.Cache.CacheSerializer;
import haxe.Serializer;
import haxe.Unserializer;
using DateTools;

/** Implements an in-memory cache. **/
class MemoryCache implements Cache {

	/** The cache data. **/
	final cache = new Map<String, MemoryCacheEntry>();

	/** The default duration in seconds before a cache entry will expire. **/
	final defaultDuration: Int;

	/** A string prefixed to every cache key so that it is unique globally in the whole cache storage. **/
	final keyPrefix: String;

	/** The instance used to serialize and unserialize cached data. **/
	final serializer: CacheSerializer;

	/** Creates a new cache service. **/
	public function new(?options: CacheOptions) {
		defaultDuration = options?.defaultDuration ?? 0;
		keyPrefix = options?.keyPrefix ?? "";
		serializer = options?.serializer ?? {serialize: Serializer.run, unserialize: Unserializer.run};
	}

	/** Removes all entries from this cache. **/
	public function clear(): Promise<Noise> {
		cache.clear();
		return Noise;
	}

	/** Gets a value indicating whether this cache contains the specified `key`. **/
	public function exists(key: String): Promise<Bool>
		return Promise.resolve(!cacheExpired(buildKey(key)));

	/** Gets the value associated with the specified `key`. Returns `None` if the `key` does not exist. **/
	public function get<T>(key: String): Promise<Option<T>>
		return cacheExpired(key) ? None : Some(serializer.unserialize(cache[buildKey(key)].value));

	/** Removes the value associated with the specified `key`. **/
	public function remove(key: String): Promise<Noise> {
		cache.remove(buildKey(key));
		return Noise;
	}

	/** Associates a given `value` with the specified `key`. **/
	public function set<T>(key: String, value: T, duration = -1): Promise<Cache> {
		if (duration < 0) duration = defaultDuration;
		cache[buildKey(key)] = {expires: duration > 0 ? Date.now().delta(duration.seconds()) : null, value: serializer.serialize(value)};
		return Promise.resolve(cast this);
	}

	/** Builds a normalized cache key from the given `key`. **/
	function buildKey(key: String): String
		return '$keyPrefix$key';

	/** Returns a value indicating whether the cached data with the specified `key` has expired. **/
	function cacheExpired(key: String): Bool {
		final prefixedKey = buildKey(key);
		if (!cache.exists(prefixedKey)) return true;

		final timestamp = cache[prefixedKey].expires;
		if (timestamp == null || timestamp.getTime() > Date.now().getTime()) return false;

		cache.remove(prefixedKey);
		return true;
	}
}

/** Defines the shape of an in-memory cache value. **/
typedef MemoryCacheEntry = {

	/** The expiration date and time. **/
	var ?expires: Date;

	/** The cached value. **/
	var value: String;
}
