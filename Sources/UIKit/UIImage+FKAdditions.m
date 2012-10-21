#import "UIImage+FKAdditions.h"

FKLoadCategory(UIImageFKAdditions);

@implementation UIImage (FKAdditions)

+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color {
    CGRect rect = (CGRect){CGPointZero, size};
    UIImage *image = nil;

    UIGraphicsBeginImageContext(size);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)preloadedImage {
    CGImageRef image = self.CGImage;

    // make a bitmap context of a suitable size to draw to, forcing decode
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);

    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef imageContext =  CGBitmapContextCreate(NULL, width, height, 8, width*4, colourSpace,
                                                       kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    CGColorSpaceRelease(colourSpace);

    // draw the image to the context, release it
    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);

    // now get an image ref from the context
    CGImageRef outputImage = CGBitmapContextCreateImage(imageContext);

    UIImage *cachedImage = [UIImage imageWithCGImage:outputImage];

    // clean up
    CGImageRelease(outputImage);
    CGContextRelease(imageContext);

    return cachedImage;
}

- (UIImage *)imageTintedWithColor:(UIColor *)color {
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [self imageTintedWithColor:color fraction:0.f]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction {
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
        UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0); // 0.0 for scale means "scale for device's main screen".
		CGRect rect = CGRectZero;
		rect.size = [self size];

		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);

		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];

		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();

		return image;
	}

	return self;
}

- (UIImage *)imageCroppedToRect:(CGRect)rect {
	// CGImageCreateWithImageInRect's `rect` parameter is in pixels of the image's coordinates system. Convert from points.
	CGFloat scale = self.scale;
	rect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);

	CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	UIImage *cropped = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	
    return cropped;
}


@end
