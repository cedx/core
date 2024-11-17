/**
 * Downloads the specified file.
 * @param file The file to be downloaded.
 */
export function downloadFile(file: File): void;

/**
 * Downloads the specified text content.
 * @param text The text content.
 * @param fileName The file name.
 * @param options The optional attributes for the file.
 */
export function downloadString(text: string, fileName: string, options?: FilePropertyBag): void;

/**
 * Opens the specified file.
 * @param file The file to be opened.
 * @param options Value indicating whether to open the file in a new tab.
 */
export function openFile(file: File, options?: {newTab?: boolean}): void;

/**
 * Prints the specified file.
 * @param file The file to be printed.
 */
export function printFile(file: File): void;

/**
 * Converts the specified file to a data URL.
 * @param file The file to convert.
 * @returns The data URL corresponding to the given file.
 */
export function toDataUrl(file: File): Promise<URL>;
