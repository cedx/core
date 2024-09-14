package belin_core.caching;

#if asys
import asys.FileSystem;
import asys.io.File as AsyncFile;
import belin_core.caching.Cache.CacheOptions;
import belin_core.caching.Cache.CacheSerializer;
import haxe.crypto.Md5;
using DateTools;
using Lambda;
using StringTools;
using haxe.io.Path;

#if php
import php.Const;
import php.Lib;
import php.Global;
#else
import haxe.Serializer;
import haxe.Unserializer;
import js.node.Fs;
#end

/** Implements a cache using files. **/
class FileCache implements Cache {

	/** The path of the directory to store cache files. **/
	public final path: String;

	/** The default duration in seconds before a cache entry will expire. **/
	final defaultDuration: Int;

	/** The cache file suffix. **/
	final fileSuffix: String;

	/** A string prefixed to every cache key so that it is unique globally in the whole cache storage. **/
	final keyPrefix: String;

	/** The instance used to serialize and unserialize cached data. **/
	final serializer: CacheSerializer;

	/** Creates a new cache service. **/
	public function new(path: String, ?options: CacheOptions & {?fileSuffix: String}) {
		this.path = path;
		defaultDuration = options?.defaultDuration ?? 0;
		fileSuffix = options?.fileSuffix ?? ".dat";
		keyPrefix = options?.keyPrefix ?? "";
		serializer = options?.serializer ?? {
			serialize: #if php Lib.serialize #else Serializer.run #end,
			unserialize: #if php Lib.unserialize #else Unserializer.run #end
		};
	}

	/** Removes all entries from this cache. **/
	public function clear(): Promise<Noise>
		return FileSystem.readDirectory(path)
			.next(files -> Promise.inSequence(files.filter(file -> file.endsWith(fileSuffix)).map(file -> FileSystem.deleteFile(Path.join([path, file])))))
			.noise();

	/** Gets a value indicating whether this cache contains the specified `key`. **/
	public function exists(key: String): Promise<Bool>
		return cacheExpired(buildKey(key)).next(expired -> !expired);

	/** Gets the value associated with the specified `key`. Returns `None` if the `key` does not exist. **/
	public function get<T>(key: String): Promise<Option<T>>
		return cacheExpired(key).next(expired -> expired ? None :
			#if !php
				AsyncFile.getContent(getFilePath(key)).next(contents -> Some(serializer.unserialize(contents)))
			#else
				Error.catchExceptions(() -> {
					final handle = Global.fopen(getFilePath(key), "r");
					Global.flock(handle, Const.LOCK_SH);
					final contents = Global.stream_get_contents(handle);
					Global.flock(handle, Const.LOCK_UN);
					Global.fclose(handle);
					contents ? Some(serializer.unserialize(contents)) : None;
				}, error -> Error.withData("Unable to read the cache file.", error))
			#end
		);

	/** Removes the value associated with the specified `key`. **/
	public function remove(key: String): Promise<Noise>
		return FileSystem.deleteFile(getFilePath(key));

	/** Associates a given `value` with the specified `key`. **/
	public function set<T>(key: String, value: T, duration: Int = -1): Promise<Cache> {
		if (duration < 0) duration = defaultDuration;
		final expires = Date.now().delta(duration > 0 ? duration.seconds() : 365.days());
		final file = getFilePath(key);
		final serializedValue = serializer.serialize(value);

		#if php
			return Global.file_put_contents(file, serializedValue, Const.LOCK_EX) && Global.touch(file, Std.int(expires.getTime() / 1.seconds()), Global.time())
				? Promise.resolve(cast this)
				: Promise.reject(new Error("Unable to write the cache file."));
		#else
			return AsyncFile.saveContent(file, serializedValue).next(_ -> {
				final trigger = Promise.trigger();
				Fs.utimes(file, Date.now(), expires, error -> error != null
					? trigger.reject(Error.withData("Unable to write the cache file.", error))
					: trigger.resolve(cast this));
				trigger.asPromise();
			});
			// return AsyncFile.saveContent(file, serializedValue)
			// 	.next(_ -> Promise.irreversible((resolve, reject) -> Fs.utimes(file, Date.now(), expires, error -> error != null
			// 		? reject(Error.withData("Unable to write the cache file.", error))
			// 		: resolve(cast this))));
		#end
	}

	/** Builds a normalized cache key from the given `key`. **/
	function buildKey(key: String): String
		return Md5.encode('$keyPrefix$key');

	/** Returns a value indicating whether the cached data with the specified `key` has expired. **/
	function cacheExpired(key: String): Promise<Bool>
		return FileSystem.stat(getFilePath(key))
			.next(stat -> stat.mtime.getTime() <= Date.now().getTime())
			.tryRecover(_ -> true);

	/** Returns the path of the cache file corresponding to the given `key`. **/
	function getFilePath(key: String): String
		return Path.join([path, '$key$fileSuffix']);
}
#end
