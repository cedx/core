import {Region} from "@cedx/core/intl/region.js"
import {assert} from "chai"

# Tests the features of the `Region` class.
describe "Region", ->
	{equal} = assert

	describe "emojiFlag", ->
		it "should return the emoji flag", ->
			map = new Map [["BR", "🇧🇷"], ["DE", "🇩🇪"], ["FR", "🇫🇷"], ["IT", "🇮🇹"], ["MX", "🇲🇽"], ["US", "🇺🇸"]]
			equal new Region(code).emojiFlag, flag for [code, flag] from map

	describe "displayName()", ->
		it "should return the localized display name", ->
			map = new Map [["de", "Frankreich"], ["en", "France"], ["es", "Francia"], ["fr", "France"], ["it", "Francia"], ["pt", "França"]]
			region = new Region "FR"
			equal region.displayName(locale), name for [locale, name] from map
