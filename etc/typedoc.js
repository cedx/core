/**
 * @type {Partial<import("typedoc").TypeDocOptions>}
 */
export default {
	entryPoints: ["../src"],
	entryPointStrategy: "expand",
	excludePrivate: true,
	gitRevision: "main",
	hideGenerator: true,
	name: "Belin.io Core",
	out: "../docs",
	readme: "none",
	tsconfig: "../src/tsconfig.json"
};
