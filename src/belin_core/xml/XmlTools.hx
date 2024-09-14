package belin_core.xml;

using StringTools;

/** Provides helper methods for XML documents. **/
abstract class XmlTools {

	/** Adds a child element to the specified `element`. **/
	public static function addChildElement(element: Xml, name: String, ?value: String, ?attributes: Map<String, String>) {
		final child = createElement(name, value, attributes);
		element.addChild(child);
		return child;
	}

	/** Creates an XML element with the specified `name` and `value`. **/
	public static function createElement(name: String, ?value: String, ?attributes: Map<String, String>) {
		final element = Xml.createElement(name);
		if (attributes != null) for (attrName => attrValue in attributes) element.set(attrName, attrValue);
		if (value != null) element.addChild(Xml.createPCData(value.htmlEscape()));
		return element;
	}
}
