import {Task, TaskStatus} from "@cedx/core/async/task.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link Task} class.
 */
describe("Task", () => {
	const {equal} = assert;
	const failure = Promise.reject(TypeError("failure"));
	const success = Promise.resolve("success");

	describe("error", () => {
		it("should return `null` if the task has completed", async () => {
			const task = new Task(() => success);
			await task.run();
			assert.isNull(task.error);
		});

		it("should return an `Error` if the task has errored", async () => {
			let task = new Task(() => failure);
			await task.run();
			assert.instanceOf(task.error, TypeError);
			equal(task.error.message, "failure");
			assert.isUndefined(task.error.cause);

			task = new Task(() => Promise.reject(123456));
			await task.run();
			assert.instanceOf(task.error, Error);
			equal(task.error.message, "The task failed.");
			equal(task.error.cause, 123456);
		});
	});

	describe("status", () => {
		it("should be `TaskStatus.initial` if the task has not been run", async () => {
			const task = new Task(() => Promise.resolve());
			equal(task.status, TaskStatus.initial);
		});

		it("should be `TaskStatus.error` if the task has errored", async () => {
			const task = new Task(() => failure);
			await task.run();
			equal(task.status, TaskStatus.error);
		});

		it("should be `TaskStatus.complete` if the task has completed", async () => {
			const task = new Task(() => success);
			await task.run();
			equal(task.status, TaskStatus.complete);
		});
	});

	describe("value", () => {
		it("should return `undefined` if the task has errored", async () => {
			const task = new Task(() => failure);
			await task.run();
			assert.isUndefined(task.value);
		});

		it("should return the value if the task has completed", async () => {
			const task = new Task(() => success);
			await task.run();
			equal(task.value, "success");
		});
	});

	describe("run()", () => {
		it("should return `undefined` if the task has errored", async () =>
			assert.isUndefined(await new Task(() => failure).run()));

		it("should return the value if the task has completed", async () =>
			equal(await new Task(() => success).run(), "success"));
	});
});
