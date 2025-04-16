import {Container} from "@cedx/core/DependencyInjection/Container.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link Container} class.
 */
describe("Container", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal, throws} = assert;
	const token = Container;

	describe("delete()", () => {
		const container = new Container().set(token, {});

		it("should properly remove a registered service", () => {
			assert.isTrue(container.has(token));
			container.delete(token);
			assert.isFalse(container.has(token));
		});
	});

	describe("get()", () => {
		const container = new Container;

		it("should properly get a registered service", () => {
			const object = {};
			equal(container.set(token, object).get(token), object);
		});

		it("should automatically instantiate the class", () => assert.instanceOf(container.get(Array), Array));
		it("should throw an error if the service is unknown", () => throws(() => container.get("UnknownToken")));
	});

	describe("has()", () => {
		const container = new Container;
		it("should return `false` if the identification token is unkown", () => assert.isFalse(container.has(token)));
		it("should return `true` if the identification token is known", () => assert.isTrue(container.set(token, {}).has(token)));
	});

	describe("register()", () => {
		const container = new Container;

		it("should properly associate a factory with an identification token", () => {
			const object = {};
			assert.isFalse(container.has(token));
			equal(container.register(token, () => object).get(token), object);
		});
	});

	describe("set()", () => {
		const container = new Container;

		it("should properly associate a service with an identification token", () => {
			const object = {};
			assert.isFalse(container.has(token));
			equal(container.set(token, object).get(token), object);
		});
	});
});
