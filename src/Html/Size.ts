/**
 * Defines the size of a component.
 */
export const Size = Object.freeze({

	/**
	 * An extra small size.
	 */
	ExtraSmall: "xs",

	/**
	 * A small size.
	 */
	Small: "sm",

	/**
	 * A medium size.
	 */
	Medium: "md",

	/**
	 * A large size.
	 */
	Large: "lg",

	/**
	 * An extra large size.
	 */
	ExtraLarge: "xl",

	/**
	 * An extra extra large size.
	 */
	ExtraExtraLarge: "xxl"
});

/**
 * Defines the size of a component.
 */
export type Size = typeof Size[keyof typeof Size];
