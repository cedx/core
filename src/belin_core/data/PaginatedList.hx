package belin_core.data;

import coconut.data.List;
import coconut.data.Model;
import tink.pure.List.NodeIterator;

/** A list with information relevant to the pagination of its items. **/
@:jsonParse(json -> new belin_core.data.PaginatedList(json))
@:jsonStringify(list -> {items: list.items, pagination: list.pagination})
final class PaginatedList<T> implements Model {

	/** The list items. **/
	@:constant var items: List<T> = @byDefault new List();

	/** The number of list items. **/
	@:computed var length: Int = items.length;

	/** The information relevant to the pagination of the list items. **/
	@:constant var pagination: Pagination = @byDefault new Pagination();

	/** Creates an empty paginated list. **/
	public static function empty<T>(pageSize: Int): PaginatedList<T>
		return new PaginatedList<T>({pagination: new Pagination({pageSize: pageSize})});

	/** Returns a new iterator that allows iterating the items of this list. **/
	public inline function iterator(): NodeIterator<T>
		return items.iterator();
}
