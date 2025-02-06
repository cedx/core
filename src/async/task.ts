/**
 * Represents an asynchronous operation.
 */
export class Task<T> {

	/**
	 * The task status.
	 */
	status: TaskStatus = TaskStatus.initial;

	/**
	 * The task result.
	 */
	#result?: Error|T;

	/**
	 * The task to perform.
	 */
	#task: (...args: Array<any>) => Promise<T>;

	/**
	 * Creates a new task.
	 * @param task The task to perform.
	 */
	constructor(task: (...args: Array<any>) => Promise<T>) {
		this.#task = task;
	}

	/**
	 * The current error of the task, if it has errored.
	 */
	get error(): Error|null {
		return this.#result instanceof Error ? this.#result : null;
	}
	set error(error: unknown) {
		this.status = TaskStatus.error;
		this.#result = error instanceof Error ? error : Error("The task failed.", {cause: error});
	}

	/**
	 * The current value of the task, if it has completed.
	 */
	get value(): T|undefined {
		return this.#result instanceof Error ? undefined : this.#result;
	}
	set value(value: T) {
		this.status = TaskStatus.complete;
		this.#result = value;
	}

	/**
	 * Runs the task.
	 * @param args The task arguments.
	 * @returns The value of the task, if it has completed.
	 */
	async run(...args: Array<any>): Promise<T|undefined> {
		this.status = TaskStatus.pending;
		try { this.value = await this.#task(...args); }
		catch (error) { this.error = error; }
		return this.value;
	}
}

/**
 * Defines the status of a task.
 */
export const TaskStatus = Object.freeze({

	/**
	 * The task has not been run.
	 */
	initial: 0,

	/**
	 * The task is running and awaiting a new value.
	 */
	pending: 1,

	/**
	 * The task completed successfully.
	 */
	complete: 2,

	/**
	 * The task errored.
	 */
	error: 3
});

/**
 * Defines the status of a task.
 */
export type TaskStatus = typeof TaskStatus[keyof typeof TaskStatus];
