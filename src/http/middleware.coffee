# Adds the properties of the specified object to the request state.
export setState = (data) -> (ctx, next) ->
	Object.assign(ctx.state, data)
	next()
