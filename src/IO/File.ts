import type {PathLike} from "node:fs";
import {readFile} from "node:fs/promises";

/**
 * Reads the file at the specified path, and converts its contents into a data URL.
 * @param path The path of the file to read.
 * @param mediaType The media type to associate with the data URL.
 * @returns The data URL corresponding to the given file.
 */
export async function toDataUrl(path: PathLike, mediaType: string): Promise<URL> {
	return new URL(`data:${mediaType};base64,${(await readFile(path)).toString("base64")}`);
}
