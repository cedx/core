/**
 * Removes all child nodes from the specified element.
 * @param element The element to empty.
 */
export function removeChildren(element: Element): void;

/**
 * Returns a promise that resolves when the specified element has finished all its animations.
 * @param element The element to query.
 * @returns The element animations.
 */
export function waitForAnimations(element: Element): Promise<Array<PromiseSettledResult<Animation>>>;
