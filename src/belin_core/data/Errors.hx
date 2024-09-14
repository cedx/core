package belin_core.data;

import tink.Json;
using Lambda;

/** Represents a set of validation errors, indexed by field. **/
@:forward(clear, exists, iterator, keyValueIterator, keys, remove)
abstract Errors(Map<String, String>) from Map<String, String> to Map<String, String> {

	/** The number of validation errors in this set. **/
	public var length(get, never): Int;
		inline function get_length() return this.count();

	/** Creates a new set of validation errors. **/
	public function new(?errors: Map<String, String>)
		this = errors ?? [];

	/** Gets the error message corresponding to the specified `field`. **/
	@:op([]) public function get(field: String): Option<String>
		return this.exists(field) ? Some(this[field]) : None;

	/** Creates a new set of validation errors from the specified `error`. **/
	@:from static function ofError(error: Error): Errors {
		final errors = switch Type.getClass(error.data) {
			case Array:
				final data: Array<Array<String>> = error.data;
				[for (entry in data) if (entry.length == 2) entry[0] => entry[1]];
			case String:
				Error.catchExceptions(() -> {
					final data: {details: Array<Array<String>>} = Json.parse(error.data);
					[for (entry in data.details) if (entry.length == 2) entry[0] => entry[1]];
				}).or(new Map());
			case _:
				new Map();
		};

		return new Errors(errors.count() > 0 ? errors : ["_" => error.message]);
	}

	/** Sets the error message of the specified `field`. **/
	@:op([]) public inline function set(field: String, message: String): String
		return this[field] = message;

	/** Converts this object to an error. **/
	@:to public function toError(): Error
		return Error.withData(UnprocessableEntity, "Invalid entity data.", [for (field => message in this) [field, message]]);

	/** Creates a new set of validation errors for which the specified field has been set. **/
	public function with(field: String, message: String): Errors {
		final map = this.copy();
		map.set(field, message);
		return new Errors(map);
	}

	/** Creates a new set of validation errors from which the specified `field` has been removed. **/
	public function without(field: String): Errors {
		final map = this.copy();
		map.remove(field);
		return new Errors(map);
	}
}
