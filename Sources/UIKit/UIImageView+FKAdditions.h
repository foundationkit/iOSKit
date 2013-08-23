// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIImageView for making life easier.
 Included is an easy way to fade a UIImageView between two images.
 */

@interface UIImageView (FKAdditions)

+ (UIImageView *)fkit_imageViewNamed:(NSString *)imageName;

- (void)fkit_setImage:(UIImage *)image animated:(BOOL)animated;
- (void)fkit_setImage:(UIImage *)image duration:(NSTimeInterval)duration;

@end
