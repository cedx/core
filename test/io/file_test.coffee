import {toDataUrl} from "@cedx/core/io/file.js"
import {assert} from "chai"
import {platform} from "node:process"

# Tests the features of the file utilities.
describe "File utilities", ->
	{equal} = assert

	describe "toDataUrl()", ->
		it "should convert the specified file to a data URL", ->
			base64 = "Q8OpZHJpYyBCZWxpbiA8Y2VkcmljQGJlbGluLmlv" + if platform is "win32" then "Pg0K" else "Pgo="
			url = await toDataUrl "AUTHORS.txt", "text/plain"
			equal url.href, "data:text/plain;base64,#{base64}"
