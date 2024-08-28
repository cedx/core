package belin_core.di;

/** Provides a dependency container. **/
class Container {

	/** The registered factories. **/
	final factories = new Map<String, () -> Any>();

	/** The registered services. **/
	final services = new Map<String, Any>();

	/** Creates a new container. **/
	public function new() {}

	/** Gets a value indicating whether this container has a service registered with the specified identifier. **/
	public function exists(id: String): Bool
		return factories.exists(id) || services.exists(id);

	/** Gets the service registered with the specified identifier. **/
	public function get<T>(id: String): Option<T> {
		if (!services.exists(id)) {
			if (!factories.exists(id)) return None;
			set(id, factories[id]());
		}

		return Some(services[id]);
	}

	/** Registers a service factory with this container. **/
	public function register<T>(id: String, factory: () -> T): Container {
		factories[id] = factory;
		return this;
	}

	/** Removes the service registered with the specified identifier. **/
	public function remove(id: String): Void {
		factories.remove(id);
		services.remove(id);
	}

	/** Registers a service instance with this container. **/
	public function set<T>(id: String, service: T): Container {
		services[id] = service;
		return this;
	}
}
