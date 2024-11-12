{spawnSync} = require "node:child_process"
console = require "node:console"
{readdirSync, rmSync} = require "node:fs"
{join} = require "node:path"
{env, exit} = require "node:process"
pkg = require "../package.json"

option "-m", "--map", "Whether to generate source maps."
tests = (join "test", file for file from readdirSync "test" when file.endsWith ".coffee")

task "build", "Builds the project.", (options) ->
	sourcemaps = if options.map then ["--map"] else []
	run "coffee", "--compile", sourcemaps..., "--no-header", "--output", "lib", "src"

task "clean", "Deletes all generated files.", ->
	files = readdirSync "lib", recursive: yes, withFileTypes: yes
	rmSync join file.parentPath, file.name for file from files when file.isFile() and not file.name.endsWith ".d.ts"
	rmSync join("var", file), recursive: yes for file from readdirSync "var" when file isnt ".gitkeep"

task "dist", "Packages the project.", ->
	invoke script for script from ["clean", "build"]
	rmSync "lib/cakefile.js"

task "lint", "Performs the static analysis of source code.", ->
	npx "coffeelint", "--file=etc/coffeelint.json", "src", "test"

task "publish", "Publishes the package.", ->
	invoke "dist"
	run "npm", "publish", "--registry=#{registry}" for registry from ["https://registry.npmjs.org", "https://npm.pkg.github.com"]
	run "git", action..., "v#{pkg.version}" for action from [["tag"], ["push", "origin"]]

task "test", "Runs the test suite.", ->
	env.NODE_ENV = "test"
	run "coffee", "--compile", "--map", "--no-header", "--output", "lib", "src", "test", tests...
	npx "rollup", "--config=etc/rollup.js"
	run "node", "lib/puppeteer.js"
	npx "mocha", "lib/server.js"

task "watch", "Watches for file changes.", (options) ->
	sourcemaps = if options.map then ["--map"] else []
	run "coffee", "--compile", sourcemaps..., "--no-header", "--output", "lib", "--watch", "src", "test", tests...

# Executes a command from a local package.
npx = (command, args...) -> run "npm", "exec", "--", command, args...

# Spawns a new process using the specified command.
run = (command, args...) ->
	{status} = spawnSync command, args, shell: on, stdio: "inherit"
	unless status is 0
		console.error "Command failed:", command, args...
		exit status
