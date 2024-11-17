/**
 * Defines contextual modifiers.
 */
export const Context: Readonly<{

	/**
	 * A danger.
	 */
	danger: "danger",

	/**
	 * An information.
	 */
	info: "info",

	/**
	 * A success.
	 */
	success: "success",

	/**
	 * A warning.
	 */
	warning: "warning"
}>;

/**
 * Defines contextual modifiers.
 */
export type Context = typeof Context[keyof typeof Context];

/**
 * Gets the icon corresponding to the specified context.
 * @param context The context.
 * @returns The icon corresponding to the specified context.
 */
export function contextIcon(context: Context): string;
