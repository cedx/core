//! --class-path src --library tink_core
import belin_core.Platform;
import belin_core.io.File;

/** Updates the version number in the sources. **/
function main()
	new File("package.json").replace(~/"version": "\d+(\.\d+){2}"/, '"version": "${Platform.packageVersion}"');
