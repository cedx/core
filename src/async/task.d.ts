/**
 * Represents an asynchronous operation.
 */
export class Task<T> {

	/**
	 * The current error of the task, if it has errored.
	 */
	error: Error|null;

	/**
	 * The task status.
	 */
	status: TaskStatus;

	/**
	 * The current value of the task, if it has completed.
	 */
	value?: T;

	/**
	 * Creates a new task.
	 * @param task The task to perform.
	 */
	constructor(task: (...args: Array<any>) => Promise<T>);

	/**
	 * Runs the task.
	 * @param args The task arguments.
	 * @returns The value of the task, if it has completed.
	 */
	run(...args: Array<any>): Promise<T|undefined>;
}

/**
 * Defines the status of a task.
 */
export const TaskStatus: Readonly<{

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
}>;

/**
 * Defines the status of a task.
 */
export type TaskStatus = typeof TaskStatus[keyof typeof TaskStatus];
