package belin_core.io;

import sys.FileSystem;
using haxe.io.Path;

/** A reference to an entity on the file system. **/
abstract class FileSystemEntity {

	/** A `FileSystemEntity` whose path is the absolute path of this entity. **/
	public var absolute(get, never): FileSystemEntity;
		abstract function get_absolute(): FileSystemEntity;

	/** Value indicating whether this object's path is absolute. **/
	public var isAbsolute(get, never): Bool;
		inline function get_isAbsolute() return path.isAbsolute();

	/** The parent directory of this entity. **/
	public var parent(get, never): Directory;
		function get_parent() return new Directory(path.directory());

	/** The path of this file system entity. **/
	public final path: String;

	/** Creates a new file system entity. **/
	public function new(path: String) this.path = path;

	/** Copies this file system entity. **/
	public abstract function copy(newPath: String): Void;

	/** Deletes this file system entity. **/
	public abstract function delete(): Void;

	/** Checks whether this file system entity exists. **/
	public inline function exists() return FileSystem.exists(path);

	/** Renames this file system entity. **/
	public inline function rename(newPath: String) FileSystem.rename(path, newPath);

	/** Calls the operating system's `stat()` function (or equivalent) on `path`. **/
	public inline function stat() return FileSystem.stat(path);

	/** Finds the type of the file system entity that a `path` points to. **/
	public static function type(path: String) return FileSystem.isDirectory(path) ? Directory : File;
}

/** Defines the type of a file system entity. **/
enum FileSystemEntityType {

	/** The file system entity is a directory. **/
	Directory;

	/** The file system entity is a file. **/
	File;
}
