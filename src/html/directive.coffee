import {html} from "lit"
import {join} from "lit/directives/join.js"

# Replaces all new lines in the specified value by HTML line breaks.
export newLineToBr = (value) -> join value.split(/\r?\n/g), html"<br>"
