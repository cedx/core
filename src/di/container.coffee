# Provides a dependency container.
export class Container

	# Creates a new container.
	constructor: ->

		# The registered factories.
		@_factories = new Map

		# The registered services.
		@_services = new Map

	# Removes the service registered with the specified identifier.
	delete: (id) ->
		@_factories.delete id
		@_services.delete id

	# Gets the service registered with the specified identifier.
	get: (id) ->
		unless @_services.has id then switch
			when @_factories.has id then @set id, @_factories.get(id)()
			when typeof id is "function" then @set id, new id
			else throw Error "There is no factory registered with the specified identifier."
		@_services.get id

	# Gets a value indicating whether this container has a service registered with the specified identifier.
	has: (id) -> @_factories.has(id) or @_services.has id

	# Registers a service factory with this container.
	register: (id, factory) ->
		@_factories.set id, factory
		this # coffeelint: disable-line = no_this

	# Registers a service instance with this container.
	set: (id, service) ->
		@_services.set id, service
		this # coffeelint: disable-line = no_this
