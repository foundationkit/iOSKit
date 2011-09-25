// Part of iOSKit http://foundationk.it
//
// Derived from Peter Steinberger's Gist: https://gist.github.com/1144242

#import <UIKit/UIKit.h>

/**
 This category adds the possiblity to preload an image to UIImage for faster drawing.
 */

@interface UIImage (FKAdditions)

- (UIImage *)preloadedImage;

@end
