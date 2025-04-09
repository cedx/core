/**
 * Defines contextual modifiers.
 */
export const Context = Object.freeze({

	/**
	 * A danger.
	 */
	Danger: "danger",

	/**
	 * An information.
	 */
	Info: "info",

	/**
	 * A success.
	 */
	Success: "success",

	/**
	 * A warning.
	 */
	Warning: "warning"
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
		case Context.Danger: return "error";
		case Context.Success: return "check_circle";
		case Context.Warning: return "warning";
		default: return "info";
	}
}
