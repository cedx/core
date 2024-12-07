# Represents an asynchronous operation.
export class Task

	# Creates a new task.
	constructor: (task) ->

		# The task status.
		@status = TaskStatus.initial

		# The task result.
		@_result = undefined

		# The task to perform.
		@_task = task

	# The current error of the task, if it has errored.
	Object.defineProperty @::, "error",
		get: -> if @_result instanceof Error then @_result else null
		set: (error) ->
			@status = TaskStatus.error
			@_result = if error instanceof Error then error else Error "The task failed.", cause: error

	# The current value of the task, if it has completed.
	Object.defineProperty @::, "value",
		get: -> if @_result instanceof Error then undefined else @_result
		set: (value) ->
			@status = TaskStatus.complete
			@_result = value

	# Runs the task.
	run: (args...) ->
		try
			@status = TaskStatus.pending
			@value = await @_task args...
		catch error
			@error = error
			@value

# Defines the status of a task.
export TaskStatus = Object.freeze

	# The task has not been run.
	initial: 0

	# The task is running and awaiting a new value.
	pending: 1

	# The task completed successfully.
	complete: 2

	# The task errored.
	error: 3
