import {TemplateResult} from "lit";

/**
 * Replaces all new lines in the specified value by HTML line breaks.
 * @param value The string to format.
 * @returns The formatted string.
 */
export function newLineToBr(value: string): Iterable<TemplateResult>;
