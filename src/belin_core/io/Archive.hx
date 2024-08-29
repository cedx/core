package belin_core.io;

import haxe.zip.Reader;
import sys.FileSystem;
import sys.io.File;
using haxe.io.Path;

/** Represents an archive. **/
class Archive extends FileSystemEntity {

	/** Creates a new archive. **/
	public function new(path: String) super(path);

	/** Gets an `Archive` whose path is the absolute path of this entity. **/
	function get_absolute(): Archive
		return isAbsolute ? this : new Archive(FileSystem.absolutePath(path));

	/** Copies this archive. **/
	public inline function copy(newPath: String): Void
		File.copy(path, newPath);

	/** Deletes this archive. **/
	public inline function delete(): Void
		FileSystem.deleteFile(path);

	/** Extracts this archive into the specified destination `directory`. **/
	public function extract(directory: String, stripComponents = 0): Outcome<Noise, Error>
		return switch path.extension().toLowerCase() {
			case "gz" if (path.withoutExtension().extension().toLowerCase() == "tar"): extractTar(directory, stripComponents);
			case "tgz": extractTar(directory, stripComponents);
			case "zip": extractZip(directory, stripComponents);
			case _: Failure(new Error(MethodNotAllowed, "Unsupported archive format."));
		}

	/** Extracts this TAR archive into the specified destination `directory`. **/
	function extractTar(directory: String, stripComponents = 0): Outcome<Noise, Error> {
		FileSystem.createDirectory(directory);
		final exitCode = Sys.command("tar", ['--directory=$directory', "--extract", '--file=$path', '--strip-components=$stripComponents']);
		return exitCode == 0 ? Success(Noise) : Failure(new Error('The "tar" command exited with code $exitCode.'));
	}

	/** Extracts this ZIP archive into the specified destination `directory`. **/
	function extractZip(directory: String, stripComponents = 0): Outcome<Noise, Error> {
		final input = File.read(path);
		final entries = Reader.readZip(input).filter(entry -> {
			if (stripComponents > 0) entry.fileName = entry.fileName.split("/").slice(stripComponents).join("/");
			entry.fileSize > 0;
		});

		for (entry in entries) {
			final output = Path.join([directory, entry.fileName]);
			FileSystem.createDirectory(output.directory());
			File.saveBytes(output, Reader.unzip(entry));
		}

		input.close();
		return Success(Noise);
	}
}
