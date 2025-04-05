import {html, type TemplateResult} from "lit";
import {join} from "lit/directives/join.js";

/**
 * Replaces all new lines in the specified value by HTML line breaks.
 * @param value The string to format.
 * @returns The formatted string.
 */
export function newLineToBr(value: string): Iterable<string|TemplateResult> {
	return join(value.split(/\r?\n/g), html`<br>`);
}
