/**
 * Defines the available color modes.
 */
export const Theme: Readonly<{

	/**
	 * The theme is light.
	 */
	light: "light",

	/**
	 * The theme is dark.
	 */
	dark: "dark",

	/**
	 * The color mode is automatic.
	 */
	auto: "auto"
}>;

/**
 * Defines the available color modes.
 */
export type Theme = typeof Theme[keyof typeof Theme];

/**
 * Gets the icon corresponding to the specified theme.
 * @param theme The theme.
 * @returns The icon corresponding to the specified theme.
 */
export function themeIcon(theme: Theme): string;

/**
 * Gets the label corresponding to the specified theme.
 * @param theme The theme.
 * @returns The label corresponding to the specified theme.
 */
export function themeLabel(theme: Theme): string;
