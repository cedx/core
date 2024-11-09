import resolve from "@rollup/plugin-node-resolve";

/** @type {import("rollup").RollupOptions} */
export default {
	context: "this",
	input: "lib/client.js",
	output: {file: "var/tests.js", format: "iife"},
	plugins: [resolve()]
};
