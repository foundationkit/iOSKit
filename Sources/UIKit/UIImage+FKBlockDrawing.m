#import "UIImage+FKBlockDrawing.h"
#import "FKSynthesizeSingleton.h"

@implementation UIImage (FKBlockDrawing)

+ (UIImage *)imageWithIdentifier:(NSString *)identifier size:(CGSize)size isOpaque:(BOOL)opaque drawingBlock:(fk_drawing_block)drawingBlock {
    UIImage *image = identifier.length > 0 ? [[self fk_imageCache] objectForKey:identifier] : nil;

    if (image == nil && (image = [self fk_imageWithSize:size isOpaque:opaque context:NULL drawingBlock:drawingBlock])) {
        if (identifier.length > 0) {
            [[self fk_imageCache] setObject:image forKey:identifier];
        }
    }

    return image;
}

+ (UIImage *)imageWithIdentifier:(NSString *)identifier size:(CGSize)size drawingBlock:(fk_drawing_block)drawingBlock {
    return [self imageWithIdentifier:identifier size:size isOpaque:NO drawingBlock:drawingBlock];
}

+ (void)invalidateCachedImageWithIdentifier:(NSString *)identifier {
    if (identifier.length > 0) {
        [[self fk_imageCache] removeObjectForKey:identifier];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

+ (NSCache *)fk_imageCache {
    FKDefineSingletonUsingBlock(^{
        return [NSCache new];
    });
}

+ (UIImage *)fk_imageWithSize:(CGSize)size isOpaque:(BOOL)opaque context:(CGContextRef)context drawingBlock:(fk_drawing_block)drawingBlock {
    if (size.width <= 0.f || size.height <= 0.f) {
        return nil;
    }

    BOOL contextSet = context != NULL;

    if (!contextSet) {
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0.f);
    }

    drawingBlock();
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    if (!contextSet) {
        UIGraphicsEndImageContext();
    }

    return image;
}

@end
