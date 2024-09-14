package belin_core.html;

import js.Browser;
using belin_core.html.FormTools;

#if tink_multipart
import haxe.io.Mime;
import js.html.File;
import js.html.FormData;
using StringTools;
using tink.io.Source;
#end

/** Tests the features of the `FormTools` class. **/
@:asserts final class FormToolsTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `isFormControl()` method. **/
	public function isFormControl() {
		// It should return `true` if the specified element is a form control.
		asserts.assert(Browser.document.createInputElement().isFormControl());
		asserts.assert(Browser.document.createSelectElement().isFormControl());
		asserts.assert(Browser.document.createTextAreaElement().isFormControl());

		// It should return `false` if the specified element is not a form control.
		asserts.assert(!Browser.document.createButtonElement().isFormControl());
		asserts.assert(!Browser.document.createDivElement().isFormControl());
		asserts.assert(!Browser.document.createFieldSetElement().isFormControl());

		return asserts.done();
	}

	/** Tests the `invalidControl()` method. **/
	public function invalidControl() {
		final form = Browser.document.createFormElement();
		final input = Browser.document.createInputElement();
		final textarea = Browser.document.createTextAreaElement();
		form.appendChild(input);
		form.appendChild(textarea);

		// It should return the first invalid control if it exists.
		input.setCustomValidity("error");
		textarea.setCustomValidity("");
		asserts.assert(form.invalidControl().equals(input));

		input.setCustomValidity("");
		textarea.setCustomValidity("error");
		asserts.assert(form.invalidControl().equals(textarea));

		// It should return `null` if all form controls are valid.
		input.setCustomValidity("");
		textarea.setCustomValidity("");
		asserts.assert(form.invalidControl() == None);

		return asserts.done();
	}

	/** Tests the `resetValidity()` method. **/
	public function resetValidity() {
		// It should reset the validity state of a single form element.
		final input = Browser.document.createInputElement();

		input.setCustomValidity("error");
		asserts.assert(!input.checkValidity());

		input.resetValidity();
		asserts.assert(input.checkValidity());

		// It should reset the validity state of all elements of a form.
		final form = Browser.document.createFormElement();

		final input = Browser.document.createInputElement();
		input.setCustomValidity("error");
		form.appendChild(input);

		final textarea = Browser.document.createTextAreaElement();
		textarea.setCustomValidity("error");
		form.appendChild(textarea);

		asserts.assert(!input.checkValidity());
		asserts.assert(!textarea.checkValidity());
		asserts.assert(!form.checkValidity());

		form.resetValidity();
		asserts.assert(input.checkValidity());
		asserts.assert(textarea.checkValidity());
		asserts.assert(form.checkValidity());

		return asserts.done();
	}

	#if tink_multipart
	/** Tests the `toMultipart()` method. **/
	public function toMultipart() {
		final form = new FormData();
		form.set("foo", "bar");
		form.set("baz", new File(["qux"], "file.txt", {type: Mime.TextPlain}));
		form.toMultipart().toIdealSource().all().handle(chunk -> {
			final body = chunk.toString();
			asserts.assert(body.contains('content-disposition: form-data; name="foo"'));
			asserts.assert(body.contains('content-disposition: form-data; name="baz"; filename="file.txt"'));
			asserts.assert(body.contains('content-type: ${Mime.TextPlain}'));
			asserts.done();
		});

		return asserts;
	}
	#end

	#if tink_url
	/** Tests the `toQuery()` method. **/
	public function toQuery() {
		final form = new FormData();
		form.set("foo", "bar");
		form.set("baz", "qux");
		return assert(form.toQuery() == "foo=bar&baz=qux");
	}
	#end

	/** Tests the `trim()` method. **/
	public function trim() {
		// It should trim the value of a single form element.
		final input = Browser.document.createInputElement();
		input.value = " \t Foo Bar \r\n ";
		input.trim();
		asserts.assert(input.value == "Foo Bar");

		// It should trim the value of all elements of a form.
		final form = Browser.document.createFormElement();

		final input = Browser.document.createInputElement();
		input.value = " \t Foo Bar \r\n ";
		form.appendChild(input);

		final textarea = Browser.document.createTextAreaElement();
		textarea.value = " \t Baz Qux \r\n ";
		form.appendChild(textarea);

		form.trim();
		asserts.assert(input.value == "Foo Bar");
		asserts.assert(textarea.value == "Baz Qux");
		return asserts.done();
	}
}
