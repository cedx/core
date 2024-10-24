package belin_core.data;

import belin_core.data.Sort.SortEntry;
import belin_core.data.Sort.SortOrder;

/** Tests the features of the `Sort` class. **/
@:asserts final class SortTest {

	/** Creates a new test. **/
	public function new() {}

	/** Tests the `length` property. **/
	public function length() {
		var sort = new Sort();
		asserts.assert(sort.length == 0);

		// It should increment when adding an entry.
		sort = sort.append("foo", Asc);
		asserts.assert(sort.length == 1);
		sort = sort.append("bar", Desc);
		asserts.assert(sort.length == 2);

		// It should decrement when removing an entry.
		sort = sort.remove("foo");
		asserts.assert(sort.length == 1);
		return asserts.done();
	}

	/** Tests the `append()` method. **/
	public function append() {
		// It should append a new entry to the end.
		var sort = Sort.of("foo").append("bar", Asc);
		asserts.compare([new SortEntry("foo", Asc), new SortEntry("bar", Asc)], sort.toArray());

		// It should move an existing entry to the end and update its value.
		sort = sort.append("foo", Desc);
		asserts.compare([new SortEntry("bar", Asc), new SortEntry("foo", Desc)], sort.toArray());
		return asserts.done();
	}

	/** Tests the `at()` method. **/
	@:variant(0, Some(new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc)))
	@:variant(1, None)
	public function at(input: Int, output: Option<SortEntry>) {
		final entry = new SortEntry("foo", Asc);
		final option = new Sort([entry]).at(input);
		return switch output {
			case None: assert(option == None);
			case Some(outcome): compare(entry, outcome);
		};
	}

	/** Tests the `compare()` method. **/
	public function testCompare() {
		final x = {index: 1, name: "abc", type: "object"};
		final y = {index: 2, name: "xyz", type: "object"};

		var sort = Sort.of("index");
		asserts.assert(sort.compare(x, y) < 0);
		sort = Sort.of("index", Desc);
		asserts.assert(sort.compare(x, y) > 0);
		sort = Sort.of("name");
		asserts.assert(sort.compare(x, y) < 0);
		sort = Sort.of("name", Desc);
		asserts.assert(sort.compare(x, y) > 0);

		sort = Sort.of("type", Asc);
		asserts.assert(sort.compare(x, y) == 0);
		sort = Sort.of("type", Desc);
		asserts.assert(sort.compare(x, y) == 0);
		sort = new Sort([new SortEntry("type", Asc), new SortEntry("index", Asc)]);
		asserts.assert(sort.compare(x, y) < 0);
		sort = new Sort([new SortEntry("type", Desc), new SortEntry("index", Desc)]);
		asserts.assert(sort.compare(x, y) > 0);

		return asserts.done();
	}

	/** Tests the `exists()` method. **/
	@:variant("foo", true)
	@:variant("bar", false)
	public function exists(input: String, output: Bool)
		return assert(Sort.of(input).exists("foo") == output);

	/** Tests the `get()` method. **/
	@:variant("foo", Some(belin_core.data.Sort.SortOrder.Asc))
	@:variant("bar", None)
	public function get(input: String, output: Option<SortOrder>) {
		final option = Sort.of("foo").get(input);
		return switch output {
			case None: assert(option == None);
			case Some(order): assert(option.equals(order));
		};
	}

	/** Tests the `getIcon()` method. **/
	@:variant(null, "swap_vert")
	@:variant(Asc, "arrow_upward")
	@:variant(Desc, "arrow_downward")
	public function getIcon(input: Null<SortOrder>, output: String)
		return assert(new Sort(input != null ? [new SortEntry("foo", input)] : []).getIcon("foo") == output);

	/** Tests the `indexOf()` method. **/
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc)], "foo", 0)
	@:variant([new tink.core.Named("bar", belin_core.data.Sort.SortOrder.Desc)], "foo", -1)
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc), new tink.core.Named("bar", belin_core.data.Sort.SortOrder.Desc)], "bar", 1)
	public function indexOf(entries: Array<SortEntry>, attribute: String, output: Int)
		return assert(new Sort(entries).indexOf(attribute) == output);

	/** Tests the `parse()` method. **/
	@:variant("", [])
	@:variant("foo", [new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc)])
	@:variant("foo,-bar", [new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc), new tink.core.Named("bar", belin_core.data.Sort.SortOrder.Desc)])
	public function parse(input: String, output: Array<SortEntry>)
		return compare(output, Sort.parse(input).toArray());

	/** Tests the `prepend()` method. **/
	public function prepend() {
		var sort = Sort.of("foo").prepend("bar", Asc);
		asserts.compare([new SortEntry("bar", Asc), new SortEntry("foo", Asc)], sort.toArray());
		sort = sort.prepend("foo", Desc);
		asserts.compare([new SortEntry("foo", Desc), new SortEntry("bar", Asc)], sort.toArray());
		return asserts.done();
	}

	/** Tests the `remove()` method. **/
	public function remove() {
		var sort = new Sort([new SortEntry("foo", Asc), new SortEntry("bar", Desc)]).remove("foo");
		asserts.compare([new SortEntry("bar", Desc)], sort.toArray());
		sort = sort.remove("bar");
		asserts.compare([], sort.toArray());
		return asserts.done();
	}

	/** Tests the `set()` method. **/
	public function set() {
		var sort = new Sort().set("foo", Asc);
		asserts.compare([new SortEntry("foo", Asc)], sort.toArray());
		sort = sort.set("bar", Asc).set("foo", Desc);
		asserts.compare([new SortEntry("foo", Desc), new SortEntry("bar", Asc)], sort.toArray());
		return asserts.done();
	}

	/** Tests the `toSql()` method. **/
	@:variant([], null, "")
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc)], null, "foo ASC")
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc), new tink.core.Named("bar", belin_core.data.Sort.SortOrder.Desc)], null, "foo ASC, bar DESC")
	@:variant([], value -> '[$value]', "")
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc)], value -> '[$value]', "[foo] ASC")
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc), new tink.core.Named("bar", belin_core.data.Sort.SortOrder.Desc)], value -> '[$value]', "[foo] ASC, [bar] DESC")
	public function toSql(input: Array<SortEntry>, escape: Null<String -> String>, output: String)
		return assert(new Sort(input).toSql(escape) == output);

	/** Tests the `toString()` method. **/
	@:variant([], "")
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc)], "foo")
	@:variant([new tink.core.Named("foo", belin_core.data.Sort.SortOrder.Asc), new tink.core.Named("bar", belin_core.data.Sort.SortOrder.Desc)], "foo,-bar")
	public function toString(input: Array<SortEntry>, output: String)
		return assert(new Sort(input) == output);
}
