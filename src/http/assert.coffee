import {isIdentifier} from "../util/number.js"
import {Status} from "./status.js"

# Asserts that a request parameter is a numeric identifier, i.e. a positive integer greater than zero.
export assertIdentifier = (ctx, options = {}) ->
	id = Number ctx[options.source ? "params"][options.field ? "id"]
	ctx.assert isIdentifier(id), options.status ? Status.notFound
	id
