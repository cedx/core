package belin_core.html;

import js.html.Element;
import js.html.FormElement;
import js.html.InputElement;
import js.html.ObjectElement;
import js.html.SelectElement;
import js.html.TextAreaElement;
using Lambda;
using StringTools;

#if tink_multipart
import js.html.File;
import js.html.FormData;
import tink.multipart.Multipart;
import tink.multipart.Part;
using tink.io.Source;
#end

/** Provides static extensions for forms. **/
abstract class FormTools {

	/** The types of form controls that are not text inputs. **/
	static final nonTextualTypes = ["button", "checkbox", "file", "hidden", "image", "password", "radio", "range", "reset", "submit"];

	/** Gets all controls belonging to the specified `form`. **/
	public static function getFormControls(form: FormElement): Array<Element>
		return [for (element in form.elements) if (isFormControl(element)) element];

	/** Returns the first invalid control from the specified `form`. **/
	public static function invalidControl(form: FormElement): Option<Element> {
		final control = form.querySelector(":not(fieldset):invalid");
		return control != null ? Some(control) : None;
	}

	/** Returns a value indicating whether the specified `element` is a form control. **/
	public static function isFormControl(element: Element): Bool
		return ([InputElement, SelectElement, TextAreaElement]: Array<Any>).contains(Type.getClass(element));

	/** Resets the validity of the specified `element`. **/
	public static function resetValidity(element: Element): Void
		switch Std.downcast(element, FormElement) {
			case null: if (isFormControl(element)) (cast element: ObjectElement).setCustomValidity("");
			case form: getFormControls(form).iter(control -> (cast control: ObjectElement).setCustomValidity(""));
		}

	#if tink_multipart
	/** Converts the specified form data into multipart data. **/
	public static function toMultipart(formData: FormData): Multipart {
		final parts = [];
		formData.forEach((value, name) -> switch Std.downcast(value, File) {
			case null: parts.push(Part.value(name, cast value));
			case file: parts.push(Part.file(name, file.name, file.type, Source.ofJsFile(name, file).idealize(_ -> Source.EMPTY)));
		});

		return new Multipart(parts);
	}
	#end

	/** Removes whitespace from both ends of the value of the specified `element`. **/
	public static function trim(element: Element): Void
		switch Type.getClass(element) {
			case FormElement:
				getFormControls((cast element: FormElement)).iter(trim);
			case InputElement:
				final control = (cast element: InputElement);
				if (!nonTextualTypes.contains(control.type)) control.value = control.value.trim();
			case TextAreaElement:
				final control = (cast element: TextAreaElement);
				control.value = control.value.trim();
		}
}
