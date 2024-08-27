package belin_core;

#if bootstrap_bundle
import js.bootstrap.Variant;
#end

/** Defines contextual modifiers. **/
enum abstract Context(String) to String {

	/** A danger. **/
	var Danger = #if bootstrap_bundle Variant.Danger #else "danger" #end;

	/** An information. **/
	var Info = #if bootstrap_bundle Variant.Info #else "info" #end;

	/** A success. **/
	var Success = #if bootstrap_bundle Variant.Success #else "success" #end;

	/** A warning. **/
	var Warning = #if bootstrap_bundle Variant.Warning #else "warning" #end;

	/** The icon corresponding to this context. **/
	public var icon(get, never): String;
		function get_icon() return switch abstract {
			case Danger: "error";
			case Info: "info";
			case Success: "check_circle";
			case Warning: "warning";
		}

	/** Creates a new context from the specified `outcome`. **/
	@:from static function ofOutcome<Data, Failure>(outcome: Outcome<Data, Failure>): Context
		return outcome.isSuccess() ? Success : Danger;
}
