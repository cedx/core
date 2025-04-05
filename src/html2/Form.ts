/**
 * The types of form controls that are not text inputs.
 */
const nonTextualTypes = new Set<string>(["button", "checkbox", "file", "hidden", "image", "password", "radio", "range", "reset", "submit"]);

/**
 * Represents a form control.
 */
export type FormControl = HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement;

/**
 * Gets all controls belonging to the specified form.
 * @param form The form element.
 * @returns The controls belonging to the specified form.
 */
export function getFormControls(form: HTMLFormElement): FormControl[] {
	return Array.from(form.elements).filter(isFormControl);
}

/**
 * Returns the first invalid control from the specified form.
 * @param form The form element.
 * @returns The first invalid control, or `null` if all controls are valid.
 */
export function invalidControl(form: HTMLFormElement): FormControl|null {
	return form.querySelector(":not(fieldset):invalid");
}

/**
 * Returns a value indicating whether the specified element is a form control.
 * @param element The element to check.
 * @returns `true` if the specified element is a form control, otherwise `false`.
 */
export function isFormControl(element: Element): element is FormControl {
	return element instanceof HTMLInputElement || element instanceof HTMLSelectElement || element instanceof HTMLTextAreaElement;
}

/**
 * Resets the validity of the specified element.
 * @param element The element to process.
 */
export function resetValidity(element: Element): void {
	if (element instanceof HTMLFormElement) getFormControls(element).forEach(control => control.setCustomValidity(""));
	else if (isFormControl(element)) element.setCustomValidity("");
}

/**
 * Removes whitespace from both ends of the value of the specified element.
 * @param element The element to process.
 */
export function trimControl(element: Element): void {
	if (element instanceof HTMLFormElement) getFormControls(element).forEach(trimControl);
	else if (element instanceof HTMLInputElement && !nonTextualTypes.has(element.type)) element.value = element.value.trim();
	else if (element instanceof HTMLTextAreaElement) element.value = element.value.trim();
}
