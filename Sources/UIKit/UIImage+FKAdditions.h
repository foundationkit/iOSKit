// Part of iOSKit http://foundationk.it
//
// Contains Stuff from Peter Steinberger's Gist: https://gist.github.com/1144242
// Contains Stuff from Matt Gemell's MGImageUtilities: http://mattgemmell.com/2010/07/05/mgimageutilities

#import <UIKit/UIKit.h>

/**
 This category adds the possiblity to preload an image to UIImage for faster drawing.
 */

@interface UIImage (FKAdditions)

- (UIImage *)preloadedImage;

/**
 This method returns a new UIImage tinted with the given color.
 It calls imageTintedWithColor:fraction: with fraction 0.
 
 @param color The Tint-Color
 @return A new image tinted with the given color
 */
- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

@end
