import tink.testrunner.Reporter.AnsiFormatter;
import tink.testrunner.Reporter.BasicReporter;
import tink.testrunner.Runner;
import tink.unit.TestBatch;

/** Runs the test suite. **/
function main() {
	final tests = TestBatch.make([
		new belin_core.AbstractEnumTest(),
		new belin_core.AnonStructTest(),
		// new belin_core.DateRangeTest(),
		// new belin_core.DateToolsTest(),
		new belin_core.NumberToolsTest(),
		// new belin_core.StringToolsTest(),
		// #if asys new belin_core.caching.FileCacheTest(), #end
		// new belin_core.caching.MemoryCacheTest(),
		// new belin_core.data.ErrorsTest(),
		// new belin_core.data.PaginationTest(),
		// new belin_core.data.SortTest(),
		new belin_core.di.ContainerTest(),
		#if (js && !nodejs) new belin_core.html.ElementToolsTest(), #end
		#if (js && !nodejs) new belin_core.html.FormToolsTest(), #end
		// #if (nodejs || sys) new belin_core.io.NetworkDriveTest(), #end
		// new belin_core.net.InternetAddressTest(),
		// new belin_core.net.MailAddressTest(),
		// new belin_core.net.PhoneNumberTest(),
		// new belin_core.net.UrlTest(),
		// new belin_core.security.AccessLevelTest()
	]);

	ANSI.stripIfUnavailable = false;
	Runner
		.run(tests, new BasicReporter(new AnsiFormatter()))
		.handle(outcome -> #if (js && !nodejs) js.Syntax.code("exit({0})", outcome.summary().failures.length) #else Runner.exit(outcome) #end);
}
