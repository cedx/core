package belin_core.io;

import haxe.io.Bytes;
import sys.FileSystem;
import sys.io.File as SysFile;
#if tink_chunk
import tink.Chunk;
#end

/** A reference to a file on the file system. **/
class File extends FileSystemEntity {

	/** Creates a new file. **/
	public function new(path: String) super(path);

	/** Gets a `File` whose path is the absolute path of this entity. **/
	function get_absolute(): File
		return isAbsolute ? this : new File(FileSystem.absolutePath(path));

	/** Copies this file. **/
	public inline function copy(newPath: String) SysFile.copy(path, newPath);

	/** Deletes this file. **/
	public inline function delete() FileSystem.deleteFile(path);

	#if tink_chunk
	/** Reads the file contents. **/
	public inline function read(): Chunk return readAsBytes();
	#end

	/** Reads the file contents as a list of bytes. **/
	public inline function readAsBytes(): Bytes
		return SysFile.getBytes(path);

	/** Reads the file contents as lines of text. **/
	public function readAsLines(): String
		return ~/\r?\n/g.split(readAsString());

	/** Reads the file contents as a string. **/
	public inline function readAsString(): String
		return SysFile.getContent(path);

	/** Replaces in this file the substring which the `pattern` matches with the given `replacement`. **/
	public function replace(pattern: EReg, replacement: String)
		SysFile.saveContent(path, pattern.replace(SysFile.getContent(path), replacement));

	#if tink_chunk
	/** Writes the specified `chunk` to this file. **/
	public inline function write(chunk: Chunk, mode: FileMode = Write) writeAsBytes(chunk, mode);
	#end

	/** Writes the specified list of `bytes` to this file. **/
	public function writeAsBytes(bytes: Bytes, mode: FileMode = Write) switch mode {
		case Append:
			final output = SysFile.append(path);
			output.writeFullBytes(bytes, 0, bytes.length);
			output.close();
		case _:
			SysFile.saveBytes(path, bytes);
	}

	/** Writes the specified string `content` to this file. **/
	public function writeAsString(content: String, mode: FileMode = Write) switch mode {
		case Append:
			final output = SysFile.append(path);
			output.writeString(content);
			output.close();
		case _:
			SysFile.saveContent(path, content);
	}
}

/** The modes in which a `File` can be opened. **/
enum FileMode {

	/** Opens the file for writing to the end of it. **/
	Append;

	/** Opens the file for reading. **/
	Read;

	/** Opens the file for writing. **/
	Write;
}
