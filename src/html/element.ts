/**
 * Removes all child nodes from the specified element.
 * @param element The element to empty.
 */
export function removeChildren(element: Element): void {
	while (element.hasChildNodes()) element.removeChild(element.lastChild!);
}

/**
 * Returns a promise that resolves when the specified element has finished all its animations.
 * @param element The element to query.
 * @returns The element animations.
 */
export function waitForAnimations(element: Element): Promise<Array<PromiseSettledResult<Animation>>> {
	return Promise.allSettled(element.getAnimations().map(animation => animation.finished));
}
