// Part of iOSKit http://foundationk.it
//
// Derived from kwigbo's UIView-Additions: http://kwigbo.tumblr.com/post/3448069097/simplify-uiview-animation-with-categories
// Derived from Sam Soffes' SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

/**
 This category adds methods to UIView for easy animated changes.
 */

@interface UIView (FKAnimations)

// Animate the changing of a views frame
- (void)fkit_setFrame:(CGRect)frame duration:(NSTimeInterval)duration;
// Animate changing the alpha of a view
- (void)fkit_setAlpha:(CGFloat)alpha duration:(NSTimeInterval)duration;

- (void)fkit_fadeIn;
- (void)fkit_fadeOut;
- (void)fkit_fadeOutAndRemoveFromSuperview;

@end
