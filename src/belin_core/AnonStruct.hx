package belin_core;

import haxe.DynamicAccess;
using StringTools;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;
#end

/** Provides helper methods for anonymous structures. **/
abstract class AnonStruct {

	/** Copies all properties from one or more source objects to the given `target` object. **/
	public static function assign(target: DynamicAccess<Any>, ...sources: DynamicAccess<Any>): DynamicAccess<Dynamic> {
		for (source in sources) for (key => value in source) target[key] = value;
		return target;
	}

	/** Gets an array of the field names in the specified structure. **/
	macro public static function getNames(anonStruct: Expr, optionalPrefix: Bool = false)
		return macro $a{getFields(anonStruct).map(field -> switch field.type {
			case TAbstract(_.toString() => type, _) if (optionalPrefix && type == "Null"): macro $v{'?${field.name}'};
			case _: macro $v{field.name};
		})};

	/** Recursively merges the properties from one or more source objects to the given `target` object. **/
	public static function merge(target: DynamicAccess<Any>, ...sources: DynamicAccess<Any>): DynamicAccess<Dynamic> {
		for (source in sources) for (key => value in source)
			if (Type.typeof(value) == TObject && Type.typeof(target[key]) == TObject) merge(target[key], value);
			else target[key] = value;

		return target;
	}

	/** Removes whitespace from both ends of the string properties of the specified `object`. **/
	public static function trim<T: {}>(object: T): T {
		for (field in Reflect.fields(object)) {
			final value: Any = Reflect.field(object, field);
			if (value is String) Reflect.setField(object, field, (value: String).trim());
		}

		return object;
	}

	#if macro
	/** Gets an array of the fields in the specified structure. **/
	static function getFields(anonStruct: Expr) {
		final type = Context.getType(anonStruct.toString());
		return switch type.follow() {
			case TAnonymous(_.get() => type): type.fields;
			case _: Context.error('"$type" should be an anonymous structure.', anonStruct.pos);
		}
	}
	#end
}
