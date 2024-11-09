# Removes all child nodes from the specified element.
export removeChildren = (element) ->
	element.removeChild element.lastChild while element.hasChildNodes()

# Returns a promise that resolves when the specified element has finished all its animations.
export waitForAnimations = (element) ->
	Promise.allSettled element.getAnimations().map (animation) -> animation.finished
