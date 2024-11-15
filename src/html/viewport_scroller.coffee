# Manages the scroll position.
export class ViewportScroller

	# Creates a new viewport scroller.
	constructor: (viewport = -> document.scrollingElement or document.documentElement) ->

		# The top offset used when scrolling to an element.
		@_scrollOffset = -1

		# The function returning the element used as viewport.
		@_viewport = viewport

	# The top offset used when scrolling to an element.
	Object.defineProperty @prototype, "scrollOffset",
		get: ->
			if @_scrollOffset < 0
				fontSize = parseInt getComputedStyle(document.body).fontSize
				@_scrollOffset = if Number.isNaN fontSize then 0 else fontSize * 2

				navbarHeight = parseInt getComputedStyle(document.documentElement).getPropertyValue "--navbar-height"
				@_scrollOffset += if Number.isNaN navbarHeight then 0 else navbarHeight

			actionBar = document.body.querySelector "action-bar"
			@_scrollOffset + (actionBar?.offsetHeight ? 0)

	# Scrolls to the specified anchor.
	scrollToAnchor: (anchor, options = {}) ->
		element = document.getElementById(anchor) or document.body.querySelector "[name=\"#{anchor}\"]"
		@scrollToElement element, options if element

	# Scrolls to the specified element.
	scrollToElement: (element, options = {}) ->
		{left, top} = element.getBoundingClientRect()
		{scrollLeft, scrollTop} = @_viewport()
		@scrollToPosition left + scrollLeft, top + scrollTop - @scrollOffset, options

	# Scrolls to the specified position.
	scrollToPosition: (x, y, options = {}) -> @_viewport().scrollTo left: x, top: y, behavior: options.behavior or "auto"

	# Scrolls to the top.
	scrollToTop: (options = {}) -> @scrollToPosition 0, 0, options
