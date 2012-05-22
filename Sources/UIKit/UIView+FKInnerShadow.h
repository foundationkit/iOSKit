// Part of iOSKit http://foundationk.it
//
// Derived from Jason Morrissey's JMTabView: https://github.com/jasonmorrissey/JMTabView

#import <UIKit/UIKit.h>

/**
 This category adds drawing methods to draw inner shadows on UIViews.
 */
@interface UIView (FKInnerShadow)

- (void)drawInnerShadowInRect:(CGRect)rect radius:(CGFloat)radius fillColor:(UIColor *)fillColor;
- (void)drawInnerShadowInRect:(CGRect)rect fillColor:(UIColor *)fillColor;

@end
