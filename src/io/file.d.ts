import {PathLike} from "node:fs";

/**
 * Reads the file at the specified path, and converts its contents into a data URL.
 * @param path The path of the file to read.
 * @param mediaType The media type to associate with the data URL.
 * @returns The data URL corresponding to the given file.
 */
export function toDataUrl(path: PathLike, mediaType: string): Promise<URL>;
