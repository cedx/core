package belin_core.io;

import belin_core.io.FileSystemEntity.FileSystemEntityType;
import sys.FileSystem;
import sys.io.File as SyncFile;
using haxe.io.Path;
using StringTools;

#if nodejs
import js.node.Os;
#elseif php
import php.Global;
#end

/** A reference to a directory on the file system. **/
class Directory extends FileSystemEntity {

	/** The current working directory. **/
	public static var current(get, never): Directory;
		static function get_current() return new Directory(Sys.getCwd());

	/** The system temporary directory. **/
	public static var systemTemp(get, null): Directory;
		static function get_systemTemp() {
			if (systemTemp == null) systemTemp = new Directory(systemTempDirectory());
			return systemTemp;
		}

	/** Creates a new directory. **/
	public function new(path: String) super(path);

	/** Gets a `Directory` whose path is the absolute path of this entity. **/
	function get_absolute(): Directory
		return isAbsolute ? this : new Directory(FileSystem.absolutePath(path));

	/** Deletes all file system entities in this directory. **/
	public function clean(?exclude: EReg) for (entry in FileSystem.readDirectory(path).filter(entry -> exclude == null || !exclude.match(entry))) {
		final entity = Path.join([path, entry]);
		FileSystem.isDirectory(entity) ? new Directory(entity).delete() : FileSystem.deleteFile(entity);
	}

	/** Copies this directory. **/
	public inline function copy(newPath: String): Void
		copyDirectory(path, newPath);

	/** Creates this directory if it doesn't exist. **/
	public inline function create(): Void
		FileSystem.createDirectory(path);

	/** Deletes this directory. **/
	public function delete(): Void {
		clean();
		FileSystem.deleteDirectory(path);
	}

	/** Lists the sub-directories and files of this directory. **/
	public function list(?options: DirectoryListOptions): Array<String>
		return options == null ? FileSystem.readDirectory(path) : {
			final directory = path.normalize();
			final length = directory.length > 0 ? directory.addTrailingSlash().length : 0;
			listDirectory(path, options).map(entity -> entity.substr(length));
		}

	/** Recursively copies all files in the specified `source` directory to a given `destination` directory. **/
	static function copyDirectory(source: String, destination: String) for (entry in FileSystem.readDirectory(source)) {
		final input = Path.join([source, entry]);
		final output = Path.join([destination, entry]);
		if (FileSystem.isDirectory(input)) copyDirectory(input, output);
		else {
			FileSystem.createDirectory(output.directory());
			SyncFile.copy(input, output);
		}
	}

	/** Returns the paths of all file system entities in the specified `directory`. **/
	static function listDirectory(directory: String, options: DirectoryListOptions): Array<String> {
		final directoryFilter = options.directoryFilter;
		final fileFilter = options.fileFilter;
		final recursive = options.recursive ?? false;
		final type = options.type;

		var paths = [];
		for (entry in FileSystem.readDirectory(directory)) {
			final path = Path.join([directory, entry]);
			if (!FileSystem.isDirectory(path)) {
				if (fileFilter != null && !fileFilter.match(entry)) continue;
				if (type == null || type == File) paths.push(path);
			}
			else {
				if (directoryFilter != null && !directoryFilter.match(entry)) continue;
				if (type == null || type == Directory) paths.push(path);
				if (!recursive) continue;
				paths = paths.concat(listDirectory(path, options));
			}
		}

		return paths;
	}

	/** Gets the path to the system temporary directory. **/
	static #if (nodejs || php) inline #end function systemTempDirectory(): String {
		#if nodejs
			return Os.tmpdir();
		#elseif php
			return Global.sys_get_temp_dir();
		#else
			final env = Platform.getEnv;
			return switch Sys.systemName() {
				case "Windows":
					final path = env("TMP").orTry(env("TEMP")).or(Path.join([env("SystemRoot").orTry(env("windir")).sure(), "Temp"]));
					path.length > 1 && !path.endsWith(":\\") ? path.removeTrailingSlashes() : path;
				case _:
					final path = env("TMPDIR").orTry(env("TMP")).orTry(env("TEMP")).or("/tmp");
					path.length > 1 ? path.removeTrailingSlashes() : path;
			}
		#end
	}
}

/** Defines the options of the `Directory.list()` method. **/
typedef DirectoryListOptions = {

	/** A pattern specifying the directories to include in the output. **/
	var ?directoryFilter: EReg;

	/** A pattern specifying the files to include in the output. **/
	var ?fileFilter: EReg;

	/** Value indicating whether to process the directory recursively. **/
	var ?recursive: Bool;

	/** A type specifying the file system entities to include in the output. **/
	var ?type: FileSystemEntityType;
}
