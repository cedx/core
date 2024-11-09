import {removeChildren} from "@cedx/core/html/element.js"
import {assert} from "chai"

# Tests the features of the element utilities.
describe "Element utilities", ->
	{isFalse, isTrue} = assert

	describe "removeChildren()", ->
		it "should remove all child nodes from the specified element", ->
			element = document.createElement "div"
			element.appendChild document.createElement "p"
			isTrue element.hasChildNodes()
			removeChildren(element)
			isFalse element.hasChildNodes()
