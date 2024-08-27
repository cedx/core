package belin_core;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;
#end

/** Provides helper methods for abstract enumerations. **/
abstract class AbstractEnum {

	/** Gets an array of the names of the fields in the specified enumeration. **/
	macro public static function getNames(abstractEnum: Expr)
		return macro $a{getFields(abstractEnum).map(field -> macro $v{field.name})};

	/** Gets an array of the values of the fields in the specified enumeration. **/
	macro public static function getValues(abstractEnum: Expr) return macro $a{getFields(abstractEnum).map(field -> {
		final fieldName = field.name;
		macro $abstractEnum.$fieldName;
	})};

	#if macro
	/** Gets an array of the fields in the specified enumeration. **/
	static function getFields(abstractEnum: Expr) {
		final type = Context.getType(abstractEnum.toString());
		return switch type.follow() {
			case TAbstract(_.get() => type, _) if (type.meta.has(":enum")):
				type.impl.get().statics.get().filter(field -> field.meta.has(":enum") && field.meta.has(":impl"));
			case _:
				Context.error('"$type" should be an abstract enum.', abstractEnum.pos);
		}
	}
	#end
}
