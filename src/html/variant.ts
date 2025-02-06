/**
 * Defines tone variants.
 */
export const Variant = Object.freeze({

	/**
	 * A dark variant.
	 */
	dark: "dark",

	/**
	 * A light variant.
	 */
	light: "light",

	/**
	 * A primary variant.
	 */
	primary: "primary",

	/**
	 * A secondary variant.
	 */
	secondary: "secondary"
});

/**
 * Defines tone variants.
 */
export type Variant = typeof Variant[keyof typeof Variant];
