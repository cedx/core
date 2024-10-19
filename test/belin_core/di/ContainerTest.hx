package belin_core.di;

/** Tests the features of the `Container` class. **/
@:asserts final class ContainerTest {

	/** The token identifying the test service. **/
	final token = Type.getClassName(Container);

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `exists()` method. **/
	public function exists() {
		final container = new Container();
		asserts.assert(!container.exists(token));
		asserts.assert(container.set(token, {}).exists(token));
		return asserts.done();
	}

	/** Tests the `get()` method. **/
	public function get() {
		final container = new Container();
		final object = {};
		asserts.assert(container.set(token, object).get(token).equals(object));
		asserts.assert(container.get("UnknownToken") == None);
		asserts.compare([], container.set(token, object).get(Type.getClassName(Array)).sure());
		return asserts.done();
	}

	/** Tests the `register()` method. **/
	public function register() {
		final container = new Container();
		final object = {};
		asserts.assert(!container.exists(token));
		asserts.assert(container.register(token, () -> object).get(token).equals(object));
		return asserts.done();
	}

	/** Tests the `remove()` method. **/
	public function remove() {
		final container = new Container().set(token, {});
		asserts.assert(container.exists(token));
		container.remove(token);
		asserts.assert(!container.exists(token));
		return asserts.done();
	}

	/** Tests the `set()` method. **/
	public function set() {
		final container = new Container();
		final object = {};
		asserts.assert(!container.exists(token));
		asserts.assert(container.set(token, object).get(token).equals(object));
		return asserts.done();
	}
}
