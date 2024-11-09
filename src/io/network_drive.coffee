import {execFile} from "node:child_process"
import {access} from "node:fs/promises"
import {join, normalize} from "node:path"
import {env, platform} from "node:process"
import {promisify} from "node:util"

# Spawns a new process using the specified command.
run = promisify execFile

# Represents a Windows network drive.
export class NetworkDrive

	# Value indicating whether this network drive is mounted.
	Object.defineProperty @prototype, "isMounted",
		get: -> try await access "#{@drive}:/"; yes catch then no

	# Creates a new network drive.
	constructor: (drive, uncPath, user = "", password = "") ->

		# The drive letter.
		@drive = drive.toUpperCase()

		# The underlying UNC path.
		@uncPath = @_normalizeUncPath uncPath

		# The password to use for mounting this network drive.
		@_password = password

		# The username to use for mounting this network drive.
		@_user = user

	# Creates a new network drive from the specified file URI.
	@fromUri: (uri) -> new @ uri.searchParams.get("drive") ? "Z",
		"\\\\#{if uri.hostname then uri.hostname else "localhost"}\\#{decodeURIComponent(uri.pathname)[1..].split("/").at 0}"
		decodeURIComponent uri.username
		decodeURIComponent uri.password

	# Returns the local path corresponding to the specified file URI.
	@resolveUri: (uri, options = {}) ->
		host = if uri.hostname then uri.hostname else "localhost"
		path = decodeURIComponent(uri.pathname).replace(/\/+$/, "")
		return Promise.resolve normalize(if /^\/[A-Z]:/i.test(path) then path[1..] else path) if uri.protocol is "file:" and host is "localhost"

		drive = @fromUri uri
		await drive.mount options if options.mount and not (await drive.isMounted)
		drive.resolve "/#{path[1..].split("/")[1..].join "/"}"

	# Mounts this network drive.
	mount: (options = {}) ->
		credentials = if @_user then ["/user:#{@_user}", @_password] else []
		flag = if options.persistent then "yes" else "no"
		@_netUse ["#{@drive}:", @uncPath, "/persistent:#{flag}", credentials...]

	# Resolves the specified UNC path into a local path.
	resolve: (path) ->
		path = @_normalizeUncPath path
		return "#{@drive}:#{path}" unless path.startsWith "\\\\"
		if path.startsWith @uncPath then "#{@drive}:#{path[@uncPath.length..]}" else path

	# Unmounts this network drive.
	unmount: -> @_netUse ["#{@drive}:", "/delete", "/yes"]

	# Runs the `net use` command.
	_netUse: (args) ->
		executable = if platform is "win32" then join env.windir ? "C:/Windows", "System32/net.exe" else "net"
		run executable, ["use", args...]

	# Normalizes the specified UNC path.
	_normalizeUncPath: (path) -> path.replaceAll("/", "\\").replace /\\+$/, ""
