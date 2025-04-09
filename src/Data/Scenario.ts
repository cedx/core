/**
 * Defines the scenario used in data validation.
 */
export const Scenario = Object.freeze({

	/**
	 * A scenario in which the underlying model is created.
	 */
	Creation: "creation",

	/**
	 * A scenario in which the underlying model is updated.
	 */
	Update: "update"
});

/**
 * Defines the scenario used in data validation.
 */
export type Scenario = typeof Scenario[keyof typeof Scenario];
