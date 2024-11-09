# The types of form controls that are not text inputs.
nonTextualTypes = new Set ["button", "checkbox", "file", "hidden", "image", "password", "radio", "range", "reset", "submit"]

# Gets all controls belonging to the specified form.
export getFormControls = (form) -> Array.from(form.elements).filter isFormControl

# Returns the first invalid control from the specified form.
export invalidControl = (form) -> form.querySelector ":not(fieldset):invalid"

# Returns a value indicating whether the specified element is a form control.
export isFormControl = (element) ->
	element instanceof HTMLInputElement or element instanceof HTMLSelectElement or element instanceof HTMLTextAreaElement

# Resets the validity of the specified element.
export resetValidity = (element) -> switch
	when element instanceof HTMLFormElement then getFormControls(element).forEach (control) -> control.setCustomValidity ""
	when isFormControl(element) then element.setCustomValidity ""

# Removes whitespace from both ends of the value of the specified element.
export trimControl = (element) -> switch
	when element instanceof HTMLFormElement then getFormControls(element).forEach trimControl
	when element instanceof HTMLInputElement and not nonTextualTypes.has element.type then element.value = element.value.trim()
	when element instanceof HTMLTextAreaElement then element.value = element.value.trim()
