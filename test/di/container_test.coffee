import {Container} from "@cedx/core/di/container.js"
import {assert} from "chai"

# Tests the features of the `Container` class.
describe "Container", ->
	{equal, instanceOf, isFalse, isTrue, throws} = assert
	token = Container

	describe "delete()", ->
		container = new Container().set token, {}
		it "should properly remove a registered service", ->
			isTrue container.has token
			container.delete token
			isFalse container.has token

	describe "get()", ->
		container = new Container

		it "should properly get a registered service", ->
			object = {}
			equal container.set(token, object).get(token), object

		it "should automatically instantiate the class", -> instanceOf container.get(Array), Array
		it "should throw an error if the service is unknown", -> throws(-> container.get "UnknownToken")

	describe "has()", ->
		container = new Container
		it "should return `false` if the identification token is unkown", -> isFalse container.has token
		it "should return `true` if the identification token is known", -> isTrue container.set(token, {}).has token

	describe "register()", ->
		container = new Container
		it "should properly associate a factory with an identification token", ->
			object = {}
			isFalse container.has token
			equal container.register(token, -> object).get(token), object

	describe "set()", ->
		container = new Container
		it "should properly associate a service with an identification token", ->
			object = {}
			isFalse container.has token
			equal container.set(token, object).get(token), object
