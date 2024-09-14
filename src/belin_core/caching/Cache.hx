package belin_core.caching;

#if php
import php.Lib;
#else
import haxe.Serializer;
import haxe.Unserializer;
#end

/** The base class for cache classes supporting different cache storage implementations. **/
abstract class Cache2 {

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
		serializer = options?.serializer ?? {
			serialize: #if php Lib.serialize #else Serializer.run #end,
			unserialize: #if php Lib.unserialize #else Unserializer.run #end
		};
	}

	/** Removes all entries from this cache. **/
	// public function clear(): Promise<Noise>
	// 	return flushValues();

	/** Gets a value indicating whether this cache contains the specified `key`. **/
	// public function exists(key: String): Promise<Bool>
	// 	return getValue(buildKey(key)).next(option -> option != None);

	/** Gets the value associated with the specified `key`. Returns `None` if the `key` does not exist. **/
	// public function get<T>(key: String): Promise<Option<T>>
	// 	return getValue(buildKey(key)).next(option -> option.map(serializer.unserialize));

	/** Removes the value associated with the specified `key`. **/
	// public function remove(key: String): Promise<Noise>
	// 	return removeValue(buildKey(key));

	/** Associates a given `value` with the specified `key`. **/
	// public function set<T>(key: String, value: T, duration = -1): Promise<Noise>
	// 	return setValue(buildKey(key), serializer.serialize(value), duration >= 0 ? duration : defaultDuration);
}

/** The base class for cache classes supporting different cache storage implementations. **/
interface Cache {

	/** Removes all entries from this cache. **/
	function clear(): Promise<Noise>;

	/** Gets a value indicating whether this cache contains the specified `key`. **/
	function exists(key: String): Promise<Bool>;

	/** Gets the value associated with the specified `key`. Returns `None` if the `key` does not exist. **/
	function get<T>(key: String): Promise<Option<T>>;

	/** Removes the value associated with the specified `key`. **/
	function remove(key: String): Promise<Noise>;

	/** Associates a given `value` with the specified `key`. **/
	function set<T>(key: String, value: T, duration: Int = -1): Promise<Cache>;
}

/** Defines the options of a `Cache` instance. **/
typedef CacheOptions = {

	/** The default duration in seconds before a cache entry will expire. **/
	var ?defaultDuration: Int;

	/** A string prefixed to every cache key so that it is unique globally in the whole cache storage. **/
	var ?keyPrefix: String;

	/** The functions used to serialize and unserialize cached data. **/
	var ?serializer: CacheSerializer;
}

/** Defines the shape of the cache serializer. **/
typedef CacheSerializer = {

	/** Serializes the specified value. **/
	var serialize: Any -> String;

	/** Unserializes the specified value. **/
	var unserialize: String -> Dynamic;
}
