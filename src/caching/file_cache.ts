import {Duration} from "#util/duration";
import {hash} from "node:crypto";
import {readdir, readFile, stat, unlink, utimes, writeFile} from "node:fs/promises";
import {join} from "node:path";
import type {Cache, CacheOptions, CacheSerializer} from "./cache.js";

/**
 * Implements a cache using files.
 */
export class FileCache implements Cache {

	/**
	 * The path of the directory to store cache files.
	 */
	readonly path: string;

	/**
	 * The default duration in seconds before a cache entry will expire.
	 */
	readonly #defaultDuration: number;

	/**
	 * The cache file suffix.
	 */
	readonly #fileSuffix: string;

	/**
	 * A string prefixed to every cache key so that it is unique globally in the whole cache storage.
	 */
	readonly #keyPrefix: string;

	/**
	 * The instance used to serialize and unserialize cached data.
	 */
	readonly #serializer: CacheSerializer;

	/**
	 * Creates a new file cache.
	 * @param path The path of the directory to store cache files.
	 * @param options An object providing values to initialize this instance.
	 */
	constructor(path: string, options: FileCacheOptions = {}) {
		this.path = path;
		this.#defaultDuration = options.defaultDuration ?? 0;
		this.#fileSuffix = options.fileSuffix ?? ".json";
		this.#keyPrefix = options.keyPrefix ?? "";
		this.#serializer = options.serializer ?? {serialize: JSON.stringify, unserialize: JSON.parse};
	}

	/**
	 * Removes all entries from this cache.
	 * @returns Resolves when this cache has been cleared.
	 */
	async clear(): Promise<void> {
		for (const file of (await readdir(this.path)).filter(item => item.endsWith(this.#fileSuffix))) await unlink(join(this.path, file));
	}

	/**
	 * Removes the value associated with the specified key.
	 * @param key The cache key.
	 * @returns Resolves when the value has been removed.
	 */
	async delete(key: string): Promise<void> {
		await unlink(this.#getFilePath(key));
	}

	/**
	 * Gets the value associated with the specified key.
	 * @param key The cache key.
	 * @returns The cached value, or `null` if the key does not exist.
	 */
	async get<T>(key: string): Promise<T|null> {
		return await this.#cacheExpired(key) ? null : this.#serializer.unserialize(await readFile(this.#getFilePath(key), "utf8")) as T;
	}

	/**
	 * Gets a value indicating whether this cache contains the specified key.
	 * @param key The cache key.
	 * @returns `true` if this cache contains the specified key, otherwise `false`.
	 */
	async has(key: string): Promise<boolean> {
		return !(await this.#cacheExpired(key));
	}

	/**
	 * Associates a given value with the specified key.
	 * @param key The cache key.
	 * @param value The value to be cached.
	 * @param duration The number of seconds in which the cached value will expire.
	 * @returns This instance.
	 */
	async set(key: string, value: unknown, duration = -1): Promise<this> {
		if (duration < 0) duration = this.#defaultDuration;
		const file = this.#getFilePath(key);
		await writeFile(file, this.#serializer.serialize(value));
		await utimes(file, new Date, (Date.now() / Duration.second) + (duration > 0 ? duration : 365 * Duration.day));
		return this;
	}

	/**
	 * Builds a normalized cache key from the given key.
	 * @param key The original key.
	 * @returns The normalized cache key.
	 */
	#buildKey(key: string): string {
		return hash("md5", `${this.#keyPrefix}${key}`);
	}

	/**
	 * Returns a value indicating whether the cached data with the specified key has expired.
	 * @param key The cache key.
	 * @returns `true` if the cached data with the specified key has expired, otherwise `false`.
	 */
	async #cacheExpired(key: string): Promise<boolean> {
		try { return (await stat(this.#getFilePath(key))).mtimeMs <= Date.now(); }
		catch { return true; }
	}

	/**
	 * Returns the path of the cache file corresponding to the given key.
	 * @param key The cache key.
	 * @returns The path of the cache file corresponding to the given key.
	 */
	#getFilePath(key: string): string {
		return join(this.path, `${this.#buildKey(key)}${this.#fileSuffix}`);
	}
}

/**
 * Defines the options of a {@link FileCache} instance.
 */
export type FileCacheOptions = CacheOptions & Partial<{

	/**
	 * The cache file suffix.
	 */
	fileSuffix: string;
}>;
