// Part of iOSKit http://foundationk.it
//
// imageRepresentation derived from Sam Soffes' SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

typedef enum {
	FKUIViewAlignmentUnchanged,
	FKUIViewAlignmentLeftAligned,
	FKUIViewAlignmentRightAligned,
    FKUIViewAlignmentTopAligned,
    FKUIViewAlignmentBottomAligned,
	FKUIViewAlignmentCentered
} FKUIViewAlignment;

/**
 This category adds various additions to UIView for making life easier.
 You get a lot of shortcuts for positioning the UIView, setting borders or shadows
 and getting the content as a UIImage
 */

@interface UIView (FKAdditions)

/**
 Setting this property sets the center of the UIView and performs CGRectIntegral on the
 frame afterwards to fix blurry views by non-integral coordinates
 */
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

/**
 Positions the current view under the given view.
 Origin.x isn't changed, because FKUIViewAlignmentUnchanged is used.
 
 @param view the view which acts as a top border of the current view
 */
- (void)positionUnderView:(UIView *)view;

/**
 Positions the current view under the given view with a specified padding.
 Origin.x isn't changed, because FKUIViewAlignmentUnchanged is used.
 
 @param view the view which acts as a left border of the current view
 @param padding the distance between view.frameBottom and self.frameTop
 */
- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding;

/**
 Positions the current view under the given view with a specified padding and alignment.
 
 @param view the view which acts as a top border of the current view
 @param alignment Specifies whether origin.x is changed to align to the left, center or right
 */
- (void)positionUnderView:(UIView *)view alignment:(FKUIViewAlignment)alignment;

/**
 Positions the current view under the given view with a specified padding.
 
 @param view the view which acts as a top border of the current view
 @param padding the distance between view.frameBottom and self.frameTop
 @param alignment Specifies whether origin.x is changed to align to the left, center or right
 */
- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment;

/**
 Positions the current view right next to the given view.
 Origin.y isn't changed, because FKUIViewAlignmentUnchanged is used.
 
 @param view the view which acts as a left border of the current view
 */
- (void)positionNextToView:(UIView *)view;

/**
 Positions the current view right next to the given view with a specified padding.
 Origin.y isn't changed, because FKUIViewAlignmentUnchanged is used.
 
 @param view the view which acts as a left border of the current view
 @param padding the distance between view.frameRight and self.frameLeft
 */
- (void)positionNextToView:(UIView *)view padding:(CGFloat)padding;

/**
 Positions the current view right next to the given view with a specified padding and alignment.
 
 @param view the view which acts as a left border of the current view
 @param alignment Specifies whether origin.y is changed to align to the top, center or bottom
 */
- (void)positionNextToView:(UIView *)view alignment:(FKUIViewAlignment)alignment;

/**
 Positions the current view right next to the given view with a specified padding.
 
 @param view the view which acts as a left border of the current view
 @param padding the distance between view.frameRight and self.frameLeft
 @param alignment Specifies whether origin.y is changed to align to the top, center or bottom
 */
- (void)positionNextToView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment;

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
