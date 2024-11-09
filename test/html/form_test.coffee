import {invalidControl, isFormControl, resetValidity, trimControl} from "@cedx/core/html/form.js"
import {assert} from "chai"

# Tests the features of the form utilities.
describe "Form utilities", ->
	{equal, isFalse, isNull, isTrue} = assert

	describe "isFormControl()", ->
		it "should return `true` if the specified element is a form control", ->
			isTrue isFormControl document.createElement "input"
			isTrue isFormControl document.createElement "select"
			isTrue isFormControl document.createElement "textarea"

		it "should return `false` if the specified element is a not form control", ->
			isFalse isFormControl document.createElement "button"
			isFalse isFormControl document.createElement "div"
			isFalse isFormControl document.createElement "fieldset"

	describe "invalidControl()", ->
		form = document.createElement "form"
		input = document.createElement "input"
		textarea = document.createElement "textarea"
		form.appendChild input
		form.appendChild textarea

		it "should return the first invalid control if it exists", ->
			input.setCustomValidity "error"
			textarea.setCustomValidity ""
			equal invalidControl(form), input

			input.setCustomValidity ""
			textarea.setCustomValidity "error"
			equal invalidControl(form), textarea

		it "should return `null` if all form controls are valid", ->
			input.setCustomValidity ""
			textarea.setCustomValidity ""
			isNull invalidControl form

	describe "resetValidity()", ->
		it "should reset the validity state of a single form element", ->
			input = document.createElement "input"

			input.setCustomValidity "error"
			isFalse input.checkValidity()

			resetValidity input
			isTrue input.checkValidity()

		it "should reset the validity state of all elements of a form", ->
			form = document.createElement "form"

			input = document.createElement "input"
			input.setCustomValidity "error"
			form.appendChild input

			textarea = document.createElement "textarea"
			textarea.setCustomValidity "error"
			form.appendChild textarea

			isFalse input.checkValidity()
			isFalse textarea.checkValidity()
			isFalse form.checkValidity()

			resetValidity form
			isTrue input.checkValidity()
			isTrue textarea.checkValidity()
			isTrue form.checkValidity()

	describe "trimControl()", ->
		it "should trim the value of a single form element", ->
			input = document.createElement "input"
			input.value = " \t Foo Bar \r\n "
			trimControl input
			equal input.value, "Foo Bar"

		it "should trim the value of all elements of a form", ->
			form = document.createElement "form"

			input = document.createElement "input"
			input.value = " \t Foo Bar \r\n "
			form.appendChild input

			textarea = document.createElement "textarea"
			textarea.value = " \t Baz Qux \r\n "
			form.appendChild textarea

			trimControl form
			equal input.value, "Foo Bar"
			equal textarea.value, "Baz Qux"
