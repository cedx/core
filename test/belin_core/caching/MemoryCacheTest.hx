package belin_core.caching;

/** Tests the features of the `MemoryCache` class. **/
@:asserts final class MemoryCacheTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `clear()` method. **/
	public function clear() {
		final cache = new MemoryCache();
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
		final cache = new MemoryCache();
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
		final cache = new MemoryCache();
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
		final cache = new MemoryCache();
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
		final cache = new MemoryCache();
		cache.get("foo")
			.next(option -> { asserts.assert(option == None); cache.set("foo", "bar"); })
			.next(_ -> cache.get("foo"))
			.next(option -> asserts.assert(option.equals("bar")))
			.handle(asserts.handle);

		return asserts;
	}
}
