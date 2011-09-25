// Part of iOSKit http://foundationk.it
//
// imageRepresentation derived from Sam Soffes' SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

typedef enum {
	FKUIViewAlignmentUnchanged,
	FKUIViewAlignmentLeftAligned,
	FKUIViewAlignmentRightAligned,
	FKUIViewAlignmentCentered
} FKUIViewAlignment;

/**
 This category adds various additions to UIView for making life easier.
 You get a lot of shortcuts for positioning the UIView, setting borders or shadows
 and getting the content as a UIImage
 */

@interface UIView (FKAdditions)

@property (nonatomic, assign) CGPoint integralCenter;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGRect integralFrame;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) CGFloat frameLeft;
@property (nonatomic, assign) CGFloat frameTop;
@property (nonatomic, assign) CGFloat frameBottom;
@property (nonatomic, assign) CGFloat frameRight;

@property (nonatomic, readonly) CGFloat boundsWidth;
@property (nonatomic, readonly) CGFloat boundsHeight;

// positions current view directly under the given view
- (void)positionUnderView:(UIView *)view;                                   // aligment = FKUIViewAlignmentUnchanged
// positions current view under a given view with a specified y-padding
- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding;          // aligment = FKUIViewAlignmentUnchanged

// positions current view directly under the given view and aligns horizontally
- (void)positionUnderView:(UIView *)view alignment:(FKUIViewAlignment)alignment;
// positions current view under a given view with a specified y-padding and aligns horizontally
- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment;

// adds the subview as a subview of the current view and centers it
- (void)addCenteredSubview:(UIView *)subview;
// moves the current view to the center of it's superview
- (void)moveToCenterOfSuperview;

- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;
- (void)setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

- (void)enableDebugBorderWithColor:(UIColor *)color;
- (void)enableDebugBorderWithRandomColor;
- (void)enableDebugBorder;

- (UIImage *)imageRepresentation;

@end
