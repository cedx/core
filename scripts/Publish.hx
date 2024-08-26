//! --class-path src --library tink_core
import belin_core.Platform;

/** Publishes the package. **/
function main() {
	Sys.command("lix Dist");
	for (action in ["tag", "push origin"]) Sys.command('git $action v${Platform.packageVersion}');
}
