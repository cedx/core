/**
 * Provides a dependency container.
 */
export class Container {

	/**
	 * The registered factories.
	 */
	readonly #factories = new Map<ContainerToken, () => any>;

	/**
	 * The registered services.
	 */
	readonly #services = new Map<ContainerToken, any>;

	/**
	 * Removes the service registered with the specified identifier.
	 * @param id The identification token.
	 */
	delete(id: ContainerToken): void {
		this.#factories.delete(id);
		this.#services.delete(id);
	}

	/**
	 * Gets the service registered with the specified identifier.
	 * @param id The identification token.
	 * @returns The instance of the service registered with the specified identifier.
	 * @throws `Error` if there is no factory registered with the specified identifier.
	 */
	get<T>(id: ContainerToken): T { // eslint-disable-line @typescript-eslint/no-unnecessary-type-parameters
		if (!this.#services.has(id))
			if (this.#factories.has(id)) this.set(id, this.#factories.get(id)!());
			else if (typeof id == "function") this.set(id, Reflect.construct(id, []));
			else throw Error("There is no factory registered with the specified identifier.");

		return this.#services.get(id) as T;
	}

	/**
	 * Gets a value indicating whether this container has a service registered with the specified identifier.
	 * @param id The identification token.
	 * @returns `true` if a service registered with the specified identifier exists in this container, otherwise `false`.
	 */
	has(id: ContainerToken): boolean {
		return this.#factories.has(id) || this.#services.has(id);
	}

	/**
	 * Registers a service factory with this container.
	 * @param id The identification token.
	 * @param factory The service factory.
	 * @returns This instance.
	 */
	register(id: ContainerToken, factory: () => unknown): this {
		this.#factories.set(id, factory);
		return this;
	}

	/**
	 * Registers a service instance with this container.
	 * @param id The identification token.
	 * @param service The service instance.
	 * @returns This instance.
	 */
	set(id: ContainerToken, service: unknown): this {
		this.#services.set(id, service);
		return this;
	}
}

/**
 * A token identifying a service.
 */
export type ContainerToken = string|symbol|(new(...args: any[]) => any);
