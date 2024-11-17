/**
 * Provides a dependency container.
 */
export class Container {

	/**
	 * Removes the service registered with the specified identifier.
	 * @param id The identification token.
	 */
	delete(id: ContainerToken): void;

	/**
	 * Gets the service registered with the specified identifier.
	 * @param id The identification token.
	 * @returns The instance of the service registered with the specified identifier.
	 * @throws `Error` if there is no factory registered with the specified identifier.
	 */
	get<T>(id: ContainerToken): T;

	/**
	 * Gets a value indicating whether this container has a service registered with the specified identifier.
	 * @param id The identification token.
	 * @returns `true` if a service registered with the specified identifier exists in this container, otherwise `false`.
	 */
	has(id: ContainerToken): boolean;

	/**
	 * Registers a service factory with this container.
	 * @param id The identification token.
	 * @param factory The service factory.
	 * @returns This instance.
	 */
	register(id: ContainerToken, factory: () => unknown): this;

	/**
	 * Registers a service instance with this container.
	 * @param id The identification token.
	 * @param service The service instance.
	 * @returns This instance.
	 */
	set(id: ContainerToken, service: unknown): this;
}

/**
 * A token identifying a service.
 */
export type ContainerToken = string|symbol|(new(...args: Array<any>) => any);
