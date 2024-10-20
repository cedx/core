package belin_core.data;

import coconut.data.List;
using Lambda;
using StringTools;

/** Represents information relevant to the sorting of data items. **/
@:forward(iterator, keyValueIterator, length, toArray)
@:jsonParse(belin_core.data.Sort.parse)
@:jsonStringify(sort -> sort.toString())
abstract Sort(List<Named<SortOrder>>) from List<Named<SortOrder>> to List<Named<SortOrder>> {

	/** Creates a new sort. **/
	public function new(?attributes: List<Named<SortOrder>>)
		this = attributes ?? new List();

	/** Appends the specified attribute to this sort. **/
	public function append(attribute: String, order: SortOrder): Sort
		return this.filter(item -> item.name != attribute).append(new Named(attribute, order));

	/** Gets the attribute/order pair at the specified index. **/
	public inline function at(index: Int): Option<Named<SortOrder>>
		return this.get(index);

	/** Compares the specified objects, according to the current sort attributes. **/
	public function compare(x: Any, y: Any): Int {
		for (item in this) {
			final value = Reflect.compare(Reflect.getProperty(x, item.name), Reflect.getProperty(y, item.name));
			if (value != 0) return item.value == Desc ? -value : value;
		}

		return 0;
	}

	/** Returns a value indicating whether the specified attribute exists in this sort. **/
	public function exists(attribute: String): Bool
		return this.exists(item -> item.name == attribute);

	/** Gets the order associated with the specified attribute. **/
	@:op([]) public function get(attribute: String): Option<SortOrder>
		return this.first(item -> item.name == attribute).map(item -> item.value);

	/** Gets the icon corresponding to the specified attribute. **/
	public function getIcon(attribute: String): String
		return switch get(attribute).orNull() {
			case Asc: "arrow_upward";
			case Desc: "arrow_downward";
			case _: "swap_vert";
		}

	/** Gets the index of the specified attribute in the underlying list, or `-1` if the attribute is not found. **/
	public function indexOf(attribute: String): Int
		return Lambda.findIndex(this, item -> item.name == attribute);

	/** Creates a new sort from the specified string. **/
	@:from public static function parse(value: String): Sort
		return new Sort(value.length == 0 ? null : [for (item in value.split(",")) {
			final order = item.startsWith("-") ? Desc : Asc;
			final attribute = order == Asc ? item : item.substr(1);
			new Named(attribute, order);
		}]);

	/** Prepends the specified attribute to this sort. **/
	public function prepend(attribute: String, order: SortOrder): Sort
		return this.filter(item -> item.name != attribute).prepend(new Named(attribute, order));

	/** Removes the specified attribute from this sort. **/
	public function remove(attribute: String): Sort
		return this.filter(item -> item.name != attribute);

	/** Sets the order of the specified attribute. **/
	@:op([]) public function set(attribute: String, order: SortOrder): Sort
		return exists(attribute) ? this.replace(item -> item.name == attribute, item -> new Named(item.name, order)) : append(attribute, order);

	/** Converts this sort to an SQL clause. **/
	public function toSql(?escape: String -> String): String
		return [for (item in this) '${escape != null ? escape(item.name) : item.name} ${item.value}'].join(", ");

	/** Returns a string representation of this object. **/
	@:to public function toString(): String
		return [for (item in this) '${item.value == Desc ? "-" : ""}${item.name}'].join(",");
}

/** Specifies the order of a sort parameter. **/
enum abstract SortOrder(String) from String to String {

	/** The sort is ascending. **/
	var Asc = "ASC";

	/** The sort is descending. **/
	var Desc = "DESC";
}
