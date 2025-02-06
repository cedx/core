/**
 * Defines contextual modifiers.
 */
export const Context = Object.freeze({

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
});

/**
 * Defines contextual modifiers.
 */
export type Context = typeof Context[keyof typeof Context];

/**
 * Gets the icon corresponding to the specified context.
 * @param context The context.
 * @returns The icon corresponding to the specified context.
 */
export function contextIcon(context: Context): string {
	switch (context) {
		case Context.danger: return "error";
		case Context.success: return "check_circle";
		case Context.warning: return "warning";
		default: return "info";
	}
}
