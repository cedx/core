package belin_core;

#if php
import php.Global;
#end

/** Provides static extensions for numbers. **/
abstract class NumberTools {

	/** Rounds a floating-point number. **/
	public static #if php inline #end function round(value: Float, precision = 0): Float {
		#if php
			return Global.round(value, precision);
		#else
			final operand = Math.pow(10, precision);
			return Math.round(value * operand) / operand;
		#end
	}
}
