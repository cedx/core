/**
 * Represents information relevant to the sorting of data items.
 */
export class Sort {

	/**
	 * The number of attributes.
	 */
	readonly length: number;

	/**
	 * Creates new sort.
	 * @param attributes The list of attributes to be sorted.
	 */
	constructor(attributes?: Array<SortEntry>)

	/**
	 * Creates a new sort from the specified attribute and order.
	 * @param attribute The sort attribute.
	 * @param order THe sort order.
	 * @returns The sort corresponding to the attribute and order.
	 */
	static of(attribute: string, order?: SortOrder): Sort;

	/**
	 * Creates a new sort from the specified string.
	 * @param value A string representing a sort.
	 * @returns The sort corresponding to the specified string.
	 */
	static parse(value: string): Sort;

	/**
	 * Returns a new iterator that allows iterating the entries of this sort.
	 * @returns An iterator over the attribute/order pairs.
	 */
	[Symbol.iterator](): IterableIterator<SortEntry>;

	/**
	 * Appends the specified attribute to this sort.
	 * @param attribute The attribute name.
	 * @param order The sort order.
	 * @returns This instance.
	 */
	append(attribute: string, order: SortOrder): this;

	/**
	 * Gets the attribute/order pair at the specified index.
	 * @param index The position in this sort.
	 * @returns The attribute/order pair at the specified index, or `null` if it doesn't exist.
	 */
	at(index: number): SortEntry|null;

	/**
	 * Compares the specified objects, according to the current sort attributes.
	 * @param x The first object to compare.
	 * @param y The second object to compare.
	 * @returns A value indicating the relationship between the two objects.
	 */
	compare(x: object, y: object): number;

	/**
	 * Removes the specified attribute from this sort.
	 * @param attribute The attribute name.
	 */
	delete(attribute: string): void;

	/**
	 * Gets the order associated with the specified attribute.
	 * @param attribute The attribute name.
	 * @returns The order associated with the specified attribute, or `null` if the attribute doesn't exist.
	 */
	get(attribute: string): SortOrder|null;

	/**
	 * Gets the icon corresponding to the specified attribute.
	 * @param attribute The attribute name.
	 * @returns The icon corresponding to the specified attribute.
	 */
	getIcon(attribute: string): string;

	/**
	 * Returns a value indicating whether the specified attribute exists in this sort.
	 * @param attribute The attribute name.
	 * @returns `true` if the specified attribute exists in this sort, otherwise `false`.
	 */
	has(attribute: string): boolean;

	/**
	 * Gets the index of the specified attribute in the underlying list.
	 * @param attribute The attribute name.
	 * @returns The index of the specified attribute, or `-1` if the attribute is not found.
	 */
	indexOf(attribute: string): number;

	/**
	 * Prepends the specified attribute to this sort.
	 * @param attribute The attribute name.
	 * @param order The sort order.
	 * @returns This instance.
	 */
	prepend(attribute: string, order: SortOrder): this;

	/**
	 * Returns a value indicating whether the current sort satisfies the specified conditions.
	 * @param conditions The conditions to satisfy.
	 * @returns `true` if the current sort satisfies the specified conditions, otherwise `false`.
	 */
	satisfies(conditions: {attributes?: Array<string>, min?: number, max?: number}): boolean;

	/**
	 * Sets the order of the specified attribute.
	 * @param attribute The attribute name.
	 * @param order The sort order.
	 * @returns This instance.
	 */
	set(attribute: string, order: SortOrder): this;

	/**
	 * Returns a JSON representation of this object.
	 * @returns The JSON representation of this object.
	 */
	toJSON(): string;

	/**
	 * Converts this sort to an SQL clause.
	 * @param escape A function used to escape the SQL identifiers.
	 * @returns The SQL clause corresponding to this object.
	 */
	toSql(escape?: (identifier: string) => string): string;

	/**
	 * Returns a string representation of this object.
	 * @returns The string representation of this object.
	 */
	toString(): string;
}

/**
 * Represents an attribute/order pair of a sort.
 */
export type SortEntry = [string, SortOrder];

/**
 * Specifies the order of a sort parameter.
 */
export const SortOrder: Readonly<{

	/**
	 * The sort is ascending.
	 */
	asc: "ASC",

	/**
	 * The sort is descending.
	 */
	desc: "DESC"
}>;

/**
 * Specifies the order of a sort parameter.
 */
export type SortOrder = typeof SortOrder[keyof typeof SortOrder];
