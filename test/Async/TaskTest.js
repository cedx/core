import {Task, TaskStatus} from "@cedx/core/Async/Task.js";
import {assert} from "chai";

/**
 * Tests the features of the {@link Task} class.
 */
describe("Task", () => {
	// eslint-disable-next-line @typescript-eslint/unbound-method
	const {equal} = assert;

	describe("error", () => {
		it("should return `null` if the task has completed", async () => {
			const task = new Task(() => Promise.resolve());
			await task.run();
			assert.isNull(task.error);
		});

		it("should return an `Error` if the task has errored", async () => {
			let task = new Task(() => Promise.reject(TypeError("failure")));
			await task.run();
			assert.instanceOf(task.error, TypeError);
			equal(task.error.message, "failure");
			assert.isUndefined(task.error.cause);

			task = new Task(() => Promise.reject(123456)); // eslint-disable-line @typescript-eslint/prefer-promise-reject-errors
			await task.run();
			assert.instanceOf(task.error, Error);
			equal(task.error.message, "The task failed.");
			equal(task.error.cause, 123456);
		});
	});

	describe("status", () => {
		it("should be `TaskStatus.initial` if the task has not been run", () => {
			const task = new Task(() => Promise.resolve());
			equal(task.status, TaskStatus.Initial);
		});

		it("should be `TaskStatus.error` if the task has errored", async () => {
			const task = new Task(() => Promise.reject(Error("failure")));
			await task.run();
			equal(task.status, TaskStatus.Error);
		});

		it("should be `TaskStatus.complete` if the task has completed", async () => {
			const task = new Task(() => Promise.resolve());
			await task.run();
			equal(task.status, TaskStatus.Complete);
		});
	});

	describe("value", () => {
		it("should return `undefined` if the task has errored", async () => {
			const task = new Task(() => Promise.reject(Error("failure")));
			await task.run();
			assert.isUndefined(task.value);
		});

		it("should return the value if the task has completed", async () => {
			const task = new Task(() => Promise.resolve("success"));
			await task.run();
			equal(task.value, "success");
		});
	});

	describe("run()", () => {
		it("should return `undefined` if the task has errored", async () =>
			assert.isUndefined(await new Task(() => Promise.reject(Error("failure"))).run()));

		it("should return the value if the task has completed", async () =>
			equal(await new Task(() => Promise.resolve("success")).run(), "success"));
	});
});
