/**
 * Defines tone variants.
 */
export const Variant = Object.freeze({

	/**
	 * A dark variant.
	 */
	Dark: "dark",

	/**
	 * A light variant.
	 */
	Light: "light",

	/**
	 * A primary variant.
	 */
	Primary: "primary",

	/**
	 * A secondary variant.
	 */
	Secondary: "secondary"
});

/**
 * Defines tone variants.
 */
export type Variant = typeof Variant[keyof typeof Variant];
