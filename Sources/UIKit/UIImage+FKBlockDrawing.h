// Part of iOSKit http://foundationk.it
//
// Derived from @kgn‘s Blog-Post: http://kgn.github.com/blog/2012/03/21/caching-drawing-code/


typedef dispatch_block_t fk_drawing_block;

/** Adds support for cached UIImages from drawing code */
@interface UIImage (FKBlockDrawing)

/**
 Returns a (possibly cached) image with the given size and drawing code
 
 @param identifier a unique identifier for the image
 @param size the size of the imageContext to create
 @param opaque flag to indicate if context is opaque
 @param drawingBlock the block that executes the drawing
 @return the image created from the drawing code
*/
+ (UIImage *)imageWithIdentifier:(NSString *)identifier size:(CGSize)size isOpaque:(BOOL)opaque drawingBlock:(fk_drawing_block)drawingBlock;

/**
 Returns a non-opaque (possibly cached) image with the given size and drawing code

 @param identifier a unique identifier for the image
 @param size the size of the imageContext to create
 @param drawingBlock the block that executes the drawing
 @return the image created from the drawing code
 */
+ (UIImage *)imageWithIdentifier:(NSString *)identifier size:(CGSize)size drawingBlock:(fk_drawing_block)drawingBlock;

/**
 Clears the image with the given identifier from the cache

 @param identifier the unique identifier for the image
 */
 + (void)invalidateCachedImageWithIdentifier:(NSString *)identifier;

@end
