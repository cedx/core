/**
 * Defines the format of an image.
 */
export const ImageFormat = Object.freeze({

	/**
	 * The image format is AV1 Image File Format (AVIF).
	 */
	avif: "avif",

	/**
	 * The image format is Graphics Interchange Format (GIF).
	 */
	gif: "gif",

	/**
	 * The image format is Joint Photographic Experts Group (JPEG).
	 */
	jpeg: "jpeg",

	/**
	 * The image format is Portable Network Graphics (PNG).
	 */
	png: "png",

	/**
	 * The image format is WebP.
	 */
	webp: "webp"
});

/**
 * Defines the format of an image.
 */
export type ImageFormat = typeof ImageFormat[keyof typeof ImageFormat];
