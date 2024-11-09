import {readFile} from "node:fs/promises"

# Reads the file at the specified path, and converts its contents into a data URL.
export toDataUrl = (path, mediaType) ->
	new URL("data:#{mediaType};base64,#{(await readFile path).toString "base64"}")
