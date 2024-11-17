/**
 * Defines the scenario used in data validation.
 */
export const Scenario: Readonly<{

	/**
	 * A scenario in which the underlying model is created.
	 */
	creation: "creation",

	/**
	 * A scenario in which the underlying model is updated.
	 */
	update: "update"
}>;

/**
 * Defines the scenario used in data validation.
 */
export type Scenario = typeof Scenario[keyof typeof Scenario];
