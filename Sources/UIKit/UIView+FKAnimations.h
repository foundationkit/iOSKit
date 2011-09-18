// Part of iOSKit http://foundationk.it
//
// Derived from kwigbo's UIView-Additions: http://kwigbo.tumblr.com/post/3448069097/simplify-uiview-animation-with-categories
// Derived from Sam Soffes' SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

@interface UIView (FKAnimations)

// Animate removing a view from its parent
- (void)removeWithTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;
// Animate adding a subview
- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration;

// Animate the changing of a views frame
- (void)setFrame:(CGRect)frame duration:(NSTimeInterval)duration;
// Animate changing the alpha of a view
- (void)setAlpha:(CGFloat)alpha duration:(NSTimeInterval)duration;

- (void)fadeIn;
- (void)fadeOut;
- (void)fadeOutAndRemoveFromSuperview;

@end
