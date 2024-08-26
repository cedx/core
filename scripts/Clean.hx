//! --class-path src --library tink_core
import belin_core.io.Directory;
using Lambda;

/** Deletes all generated files. **/
function main() {
	["lib", "res"].map(Directory.new).iter(directory -> if (directory.exists()) directory.delete());
	new Directory("var").clean(~/^\.gitkeep$/);
}
