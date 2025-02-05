import {capitalize, newLineToBr, reverse, split, stripTags, trimArray, trimObject, truncate, xmlEscape} from "@cedx/core/util/string.js";
import {assert} from "chai";

/**
 * Tests the features of the string utilities.
 */
describe("String utilities", () => {
	const {deepEqual, equal} = assert;

	// TODO !!!!! suppress debug statement
	console.log(`LOCALE: ${navigator.language}`);

	describe("capitalize()", () => {
		it("should convert in uppercase the first character of the specified string", () => {
			equal(capitalize(""), "");
			equal(capitalize("foo bAr baZ"), "Foo bAr baZ");
		});
	});

	describe("newLineToBr()", () => {
		it("should replace all new lines by HTML line breaks", () => {
			equal(newLineToBr(""), "");
			equal(newLineToBr("foo isn't\r\n bar"), "foo isn't<br> bar");
		});
	});

	describe("reverse()", () => {
		it("should reverse the characters of the specified string", () => {
			equal(reverse(""), "");
			equal(reverse("foo bar"), "rab oof");
			equal(reverse("Cédric"), "cirdéC");
		});
	});

	describe("split()", () => {
		it("should split the string into chunks of the specified length", () => {
			deepEqual(split(""), []);
			deepEqual(split("héhé", 1), ["h", "é", "h", "é"]);
			deepEqual(split("foo", 2), ["fo", "o"]);
			deepEqual(split("foobar", 3), ["foo", "bar"]);
			deepEqual(split("foo", 4), ["foo"]);
		});
	});

	describe("stripTags()", () => {
		it("should remove the HTML tags from the specified string", () => {
			equal(stripTags(""), "");
			equal(stripTags("> foo / bar <"), "> foo / bar <");
			equal(stripTags('<p>Test paragraph.</p><!-- Comment --> <a href="#fragment">Other text</a>.'), "Test paragraph. Other text.");
		});
	});

	describe("trimArray()", () => {
		it("should trim the items of the specified array", () => {
			/** @type {unknown[]} */
			let array = [];
			deepEqual(trimArray(array), []);

			array = [123, " foo ", 456, "  bar  "];
			deepEqual(trimArray(array), [123, "foo", 456, "bar"]);
		});
	});

	describe("trimObject()", () => {
		it("should trim the properties of the specified object", () => {
			/** @type {Record<string, unknown>} */
			let object = {};
			deepEqual(trimObject(object), {});

			object = {prop1: 123, prop2: " foo ", prop3: 456, prop4: "  bar  "};
			deepEqual(trimObject(object), {prop1: 123, prop2: "foo", prop3: 456, prop4: "bar"});
		});
	});

	describe("truncate()", () => {
		it("should truncate the string to the specified length", () => {
			equal(truncate("", 0), "");
			equal(truncate("foo bar", 7), "foo bar");
			equal(truncate("foo bar", 0), "...");
			equal(truncate("foo bar", 4), "foo ...");
		});

		it("should append the specified ellipsis to the truncated string", () => {
			equal(truncate("foo bar", 0, "--"), "--");
			equal(truncate("foo bar", 4, "--"), "foo --");
		});
	});

	describe("xmlEscape()", () => {
		it("should replace invalid XML characters with their valid XML equivalent", () => {
			equal(xmlEscape(""), "");
			equal(xmlEscape('"Hey!"'), "&quot;Hey!&quot;");
			equal(xmlEscape(" <foo> & <bar> "), " &lt;foo&gt; &amp; &lt;bar&gt; ");
		});
	});
});
