/**
 * Defines the status of a task.
 */
export const TaskStatus = Object.freeze({

	/**
	 * The task has not been run.
	 */
	Initial: 0,

	/**
	 * The task is running and awaiting a new value.
	 */
	Pending: 1,

	/**
	 * The task completed successfully.
	 */
	Complete: 2,

	/**
	 * The task errored.
	 */
	Error: 3
});

/**
 * Defines the status of a task.
 */
export type TaskStatus = typeof TaskStatus[keyof typeof TaskStatus];

/**
 * Represents an asynchronous operation.
 */
export class Task<T> {

	/**
	 * The task status.
	 */
	status: TaskStatus = TaskStatus.Initial;

	/**
	 * The task result.
	 */
	#result?: Error|T;

	/**
	 * The task to perform.
	 */
	readonly #task: (...args: any[]) => Promise<T>;

	/**
	 * Creates a new task.
	 * @param task The task to perform.
	 */
	constructor(task: (...args: any[]) => Promise<T>) {
		this.#task = task;
	}

	/**
	 * The current error of the task, if it has errored.
	 */
	get error(): Error|null {
		return this.#result instanceof Error ? this.#result : null;
	}
	set error(error: unknown) {
		this.status = TaskStatus.Error;
		this.#result = error instanceof Error ? error : Error("The task failed.", {cause: error});
	}

	/**
	 * The current value of the task, if it has completed.
	 */
	get value(): T|undefined {
		return this.#result instanceof Error ? undefined : this.#result; // eslint-disable-line no-undefined
	}
	set value(value: T|undefined) {
		this.status = TaskStatus.Complete;
		this.#result = value;
	}

	/**
	 * Runs the task.
	 * @param args The task arguments.
	 * @returns The value of the task, if it has completed.
	 */
	async run(...args: any[]): Promise<T|undefined> {
		this.status = TaskStatus.Pending;
		try { this.value = await this.#task(...args); } // eslint-disable-line @typescript-eslint/no-unsafe-argument
		catch (error) { this.error = error; }
		return this.value;
	}
}
