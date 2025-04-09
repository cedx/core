/**
 * Defines the format of an image.
 */
export const ImageFormat = Object.freeze({

	/**
	 * The image format is AV1 Image File Format (AVIF).
	 */
	Avif: "avif",

	/**
	 * The image format is Graphics Interchange Format (GIF).
	 */
	Gif: "gif",

	/**
	 * The image format is Joint Photographic Experts Group (JPEG).
	 */
	Jpeg: "jpeg",

	/**
	 * The image format is Portable Network Graphics (PNG).
	 */
	Png: "png",

	/**
	 * The image format is WebP.
	 */
	WebP: "webp"
});

/**
 * Defines the format of an image.
 */
export type ImageFormat = typeof ImageFormat[keyof typeof ImageFormat];

/**
 * The media types corresponding to the image formats.
 */
export const imageTypes = new Set<string>(Object.values(ImageFormat).map(type => `image/${type}`));
