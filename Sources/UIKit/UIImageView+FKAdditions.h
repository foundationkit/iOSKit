// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIImageView for making life easier.
 Included is an easy way to fade a UIImageView between two images.
 */

@interface UIImageView (FKAdditions)

+ (UIImageView *)imageViewNamed:(NSString *)imageName;

- (void)setImage:(UIImage *)image animated:(BOOL)animated;
- (void)setImage:(UIImage *)image duration:(NSTimeInterval)duration;

@end
