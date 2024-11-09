/**
 * Represents a form control.
 */
export type FormControl = HTMLInputElement|HTMLSelectElement|HTMLTextAreaElement;

/**
 * Gets all controls belonging to the specified form.
 * @param form The form element.
 * @returns The controls belonging to the specified form.
 */
export function getFormControls(form: HTMLFormElement): Array<FormControl>;

/**
 * Returns the first invalid control from the specified form.
 * @param form The form element.
 * @returns The first invalid control, or `null` if all controls are valid.
 */
export function invalidControl(form: HTMLFormElement): FormControl|null;

/**
 * Returns a value indicating whether the specified element is a form control.
 * @param element The element to check.
 * @returns `true` if the specified element is a form control, otherwise `false`.
 */
export function isFormControl(element: Element): element is FormControl;

/**
 * Resets the validity of the specified element.
 * @param element The element to process.
 */
export function resetValidity(element: Element): void;

/**
 * Removes whitespace from both ends of the value of the specified element.
 * @param element The element to process.
 */
export function trimControl(element: Element): void;
