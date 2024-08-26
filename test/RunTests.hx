import tink.testrunner.Reporter.AnsiFormatter;
import tink.testrunner.Reporter.BasicReporter;
import tink.testrunner.Runner;
import tink.unit.TestBatch;

/** Runs the test suite. **/
function main() {
	final tests = TestBatch.make([
		// new core.AbstractEnumTest(),
		// new core.AnonStructTest(),
		// new core.DateRangeTest(),
		// new core.DateToolsTest(),
		// new core.NumberToolsTest(),
		// new core.StringToolsTest(),
		// #if asys new core.caching.FileCacheTest(), #end
		// new core.caching.MemoryCacheTest(),
		// new core.data.ErrorsTest(),
		// new core.data.PaginationTest(),
		// new core.data.SortTest(),
		// new core.di.ContainerTest(),
		// #if (js && !nodejs) new core.html.FormToolsTest(), #end
		// #if (nodejs || sys) new core.io.NetworkDriveTest(), #end
		// new core.net.InternetAddressTest(),
		// new core.net.MailAddressTest(),
		// new core.net.PhoneNumberTest(),
		// new core.net.UrlTest(),
		// new core.security.AccessLevelTest()
	]);

	ANSI.stripIfUnavailable = false;
	Runner
		.run(tests, new BasicReporter(new AnsiFormatter()))
		.handle(outcome -> #if (js && !nodejs) js.Syntax.code("exit({0})", outcome.summary().failures.length) #else Runner.exit(outcome) #end);
}
