import {Duration} from "../util/duration.js"

# Downloads the specified file.
export downloadFile = (file) ->
	url = URL.createObjectURL file
	anchor = document.createElement "a"
	anchor.download = file.name
	anchor.href = url

	document.body.appendChild anchor
	anchor.click()
	document.body.removeChild anchor
	URL.revokeObjectURL url

# Downloads the specified text content.
export downloadString = (text, fileName, options = {}) ->
	downloadFile new File [text], fileName, options

# Opens the specified file.
export openFile = (file, options = {}) ->
	url = URL.createObjectURL file
	return location.assign url unless options.newTab

	handle = window.open url, "_blank"
	return location.assign url unless handle

	handler = -> if handle.closed
		clearInterval timer
		URL.revokeObjectURL url
	timer = setInterval handler, 5 * Duration.second

# Prints the specified file.
export printFile = (file) ->
	url = URL.createObjectURL file
	frame = document.createElement "iframe"
	frame.addEventListener "load", -> frame.contentWindow.print()
	frame.hidden = yes
	frame.src = url

	handler = ->
		document.body.removeChild frame
		URL.revokeObjectURL url
	window.addEventListener "focus", handler, once: yes
	document.body.appendChild frame

# Converts the specified file to a data URL.
export toDataUrl = (file) -> new Promise (resolve, reject) ->
	reader = new FileReader
	reader.addEventListener "error", reject
	reader.addEventListener "load", (-> resolve new URL reader.result)
	reader.readAsDataURL file
