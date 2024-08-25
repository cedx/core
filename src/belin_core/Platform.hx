package belin_core;

#if macro
import haxe.Json;
import haxe.macro.Context;
#end
#if (nodejs || sys)
import sys.io.File;
using haxe.io.Path;
#end

/** Information about the environment in which the current program is running. **/
abstract class Platform {

	#if (nodejs || sys)
	/** The path to the Haxe library directory. **/
	public static var haxelibPath(get, never): String;
		static function get_haxelibPath() return getEnv("HAXESHIM_LIBCACHE")
			.orTry(getEnv("HAXE_LIBCACHE"))
			.or(Path.join([haxePath, "haxe_libraries"]));

	/** The path to the Haxe compiler directory. **/
	public static var haxePath(get, never): String;
		static function get_haxePath() return getEnv("HAXESHIM_ROOT")
			.orTry(getEnv("HAXE_ROOT"))
			.or(Path.join([getEnv(Sys.systemName() == "Windows" ? "APPDATA" : "HOME").sure(), "haxe"]));
	#end

	/** The name of the Haxe compilation target. **/
	public static var haxeTarget(get, never): String;
		static inline function get_haxeTarget() return getHaxeTarget();

	/** The version number of the Haxe compiler. **/
	public static var haxeVersion(get, never): String;
		static inline function get_haxeVersion() return getHaxeVersion();

	/** The package version of this program. **/
	public static var packageVersion(get, null): String;
		static function get_packageVersion() {
			if (packageVersion == null) packageVersion = #if display "0.0.0" #else getPackageVersion() #end;
			return packageVersion;
		}

	#if (nodejs || sys)
	/** Returns the value of the specified environment variable. **/
	public static function getEnv(name: String): Option<String>
		return switch Sys.getEnv(name) {
			case null | "": None;
			case value: Some(value);
		}

	/** Returns the location of the specified Haxe library. **/
	public static function resolveLibrary(library: String, ?basePath: String): String {
		final hxml = Path.join([basePath ?? Sys.getCwd(), 'haxe_libraries/$library.hxml']);
		return Path.join([haxelibPath, ~/\r?\n/.split(File.getContent(hxml)).shift().split(" ").pop()]);
	}
	#end

	/** Gets the name of the Haxe compilation target. **/
	macro static function getHaxeTarget()
		return macro $v{Context.definedValue("target.name")};

	/** Gets the version number of the Haxe compiler. **/
	macro static function getHaxeVersion()
		return macro $v{Context.definedValue("haxe")};

	/** Gets the package version of this program. **/
	macro static function getPackageVersion()
		return macro $v{Json.parse(File.getContent("haxelib.json")).version};
}
