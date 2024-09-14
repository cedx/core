package belin_core.caching;

import sys.FileSystem;
using Lambda;
using haxe.io.Path;

/** Tests the features of the `FileCache` class. **/
@:asserts final class FileCacheTest {

	/** The cache instance used by the tests. **/
	var cache: FileCache;

	/** Creates a new test. **/
	public function new() {}

	/** This method is invoked after each test. **/
	@:after public function after() {
		FileSystem.readDirectory(cache.path).iter(file -> FileSystem.deleteFile(Path.join([cache.path, file])));
		FileSystem.deleteDirectory(cache.path);
		return Noise;
	}

	/** This method is invoked before each test. **/
	@:before public function before() {
		FileSystem.createDirectory("var/cache");
		cache = new FileCache("var/cache");
		return Noise;
	}

	/** Tests the `clear()` method. **/
	public function clear() {
		cache.set("foo", "bar")
			.next(_ -> cache.exists("foo"))
			.next(exists -> { asserts.assert(exists); cache.clear(); })
			.next(_ -> cache.exists("foo"))
			.next(exists -> asserts.assert(!exists))
			.handle(asserts.handle);

		return asserts;
	}

	/** Tests the `exists()` method. **/
	public function exists() {
		cache.exists("foo")
			.next(exists -> { asserts.assert(!exists); cache.set("foo", "bar"); })
			.next(_ -> cache.exists("foo"))
			.next(exists -> { asserts.assert(exists); cache.set("foo", "bar", 1); })
			.next(_ -> Future.delay(1_500, () -> cache.exists("foo")))
			.next(promise -> promise.next(exists -> asserts.assert(!exists)))
			.handle(asserts.handle);

		return asserts;
	}

	/** Tests the `get()` method. **/
	public function get() {
		cache.get("foo")
			.next(option -> { asserts.assert(option == None); cache.set("foo", "bar"); })
			.next(_ -> cache.get("foo"))
			.next(option -> { asserts.assert(option.equals("bar")); cache.set("foo", "bar", 1); })
			.next(_ -> Future.delay(1_500, () -> cache.get("foo")))
			.next(promise -> promise.next(option -> asserts.assert(option == None)))
			.handle(asserts.handle);

		return asserts;
	}

	/** Tests the `remove()` method. **/
	public function remove() {
		cache.set("foo", "bar")
			.next(_ -> cache.exists("foo"))
			.next(exists -> { asserts.assert(exists); cache.remove("foo"); })
			.next(_ -> cache.exists("foo"))
			.next(exists -> asserts.assert(!exists))
			.handle(asserts.handle);

		return asserts;
	}

	/** Tests the `set()` method. **/
	public function set() {
		cache.get("foo")
			.next(option -> { asserts.assert(option == None); cache.set("foo", "bar"); })
			.next(_ -> cache.get("foo"))
			.next(option -> asserts.assert(option.equals("bar")))
			.handle(asserts.handle);

		return asserts;
	}
}
