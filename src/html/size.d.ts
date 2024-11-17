/**
 * Defines the size of a component.
 */
export const Size: Readonly<{

	/**
	 * An extra small size.
	 */
	extraSmall: "xs",

	/**
	 * A small size.
	 */
	small: "sm",

	/**
	 * A medium size.
	 */
	medium: "md",

	/**
	 * A large size.
	 */
	large: "lg",

	/**
	 * An extra large size.
	 */
	extraLarge: "xl",

	/**
	 * An extra extra large size.
	 */
	extraExtraLarge: "xxl"
}>;

/**
 * Defines the size of a component.
 */
export type Size = typeof Size[keyof typeof Size];
