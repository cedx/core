/**
 * Defines the available color modes.
 */
export const Theme = Object.freeze({

	/**
	 * The theme is light.
	 */
	Light: "light",

	/**
	 * The theme is dark.
	 */
	Dark: "dark",

	/**
	 * The color mode is automatic.
	 */
	Auto: "auto"
});

/**
 * Defines the available color modes.
 */
export type Theme = typeof Theme[keyof typeof Theme];

/**
 * Gets the icon corresponding to the specified theme.
 * @param theme The theme.
 * @returns The icon corresponding to the specified theme.
 */
export function themeIcon(theme: Theme): string {
	switch (theme) {
		case Theme.Dark: return "dark_mode";
		case Theme.Light: return "light_mode";
		default: return "tonality";
	}
}

/**
 * Gets the label corresponding to the specified theme.
 * @param theme The theme.
 * @returns The label corresponding to the specified theme.
 */
export function themeLabel(theme: Theme): string {
	switch (theme) {
		case Theme.Dark: return "Sombre";
		case Theme.Light: return "Clair";
		default: return "Auto";
	}
}
