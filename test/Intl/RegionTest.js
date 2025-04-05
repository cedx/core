import {Region} from "@cedx/core/intl/region.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link Region} class.
 */
describe("Region", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("emojiFlag", () => {
		it("should return the emoji flag", () => {
			const map = new Map([["BR", "🇧🇷"], ["DE", "🇩🇪"], ["FR", "🇫🇷"], ["IT", "🇮🇹"], ["MX", "🇲🇽"], ["US", "🇺🇸"]]);
			for (const [code, flag] of map) equal(new Region(code).emojiFlag, flag);
		});
	});

	describe("displayName()", () => {
		it("should return the localized display name", () => {
			const map = new Map([["de", "Frankreich"], ["en", "France"], ["es", "Francia"], ["fr", "France"], ["it", "Francia"], ["pt", "França"]]);
			const region = new Region("FR");
			for (const [locale, name] of map) equal(region.displayName(locale), name);
		});
	});
});
