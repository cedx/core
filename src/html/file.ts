import {Duration} from "../util/duration.js";

/**
 * Downloads the specified file.
 * @param file The file to be downloaded.
 */
export function downloadFile(file: File): void {
	const url = URL.createObjectURL(file);
	const anchor = document.createElement("a");
	anchor.download = file.name;
	anchor.href = url;

	document.body.appendChild(anchor);
	anchor.click();
	document.body.removeChild(anchor);
	URL.revokeObjectURL(url);
}

/**
 * Downloads the specified text content.
 * @param text The text content.
 * @param fileName The file name.
 * @param options The optional attributes for the file.
 */
export function downloadString(text: string, fileName: string, options: FilePropertyBag = {}): void {
	downloadFile(new File([text], fileName, options));
}

/**
 * Opens the specified file.
 * @param file The file to be opened.
 * @param options Value indicating whether to open the file in a new tab.
 */
export function openFile(file: File, options: {newTab?: boolean} = {}): void {
	const url = URL.createObjectURL(file);
	if (!options.newTab) {
		location.assign(url);
		return;
	}

	const handle = window.open(url, "_blank");
	if (!handle)  {
		location.assign(url);
		return;
	}

	const timer = window.setInterval(() => {
		if (!handle.closed) return;
		clearInterval(timer);
		URL.revokeObjectURL(url);
	}, 5 * Duration.second);
}

/**
 * Prints the specified file.
 * @param file The file to be printed.
 */
export function printFile(file: File): void {
	const url = URL.createObjectURL(file);
	const frame = document.createElement("iframe");
	frame.addEventListener("load", () => frame.contentWindow?.print());
	frame.hidden = true;
	frame.src = url;

	window.addEventListener("focus", () => {
		document.body.removeChild(frame);
		URL.revokeObjectURL(url);
	}, {once: true});

	document.body.appendChild(frame);
}

/**
 * Converts the specified file to a data URL.
 * @param file The file to convert.
 * @returns The data URL corresponding to the given file.
 */
export function toDataUrl(file: File): Promise<URL> {
	return new Promise((resolve, reject) => {
		const reader = new FileReader;
		reader.addEventListener("error", reject);
		reader.addEventListener("load", () => resolve(new URL(reader.result as string)));
		reader.readAsDataURL(file);
	});
}
