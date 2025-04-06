import {removeChildren} from "@cedx/core/Html/Element.js";
import {assert} from "chai";

/**
 * Tests the features of the element utilities.
 */
describe("Element utilities", () => {
	describe("removeChildren()", () => {
		it("should remove all child nodes from the specified element", () => {
			const element = document.createElement("div");
			element.appendChild(document.createElement("p"));
			assert.isTrue(element.hasChildNodes());
			removeChildren(element);
			assert.isFalse(element.hasChildNodes());
		});
	});
});
