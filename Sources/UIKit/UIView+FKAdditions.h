// Part of iOSKit http://foundationk.it
//
// imageRepresentation derived from Sam Soffes' SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

/**
 Enum used in the postionUnderView: and positionNextToView: methods and specifies
 how the view gets positioned relative to a specified view
 */
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
/** assignable shortcut for self.center.x */
@property (nonatomic, assign) CGFloat centerX;
/** assignable shortcut for self.center.y */
@property (nonatomic, assign) CGFloat centerY;

/** setting this property sets the frame of the view to an integral frame */
@property (nonatomic, assign) CGRect integralFrame;
/** assignable shortcut form self.frame.origin */
@property (nonatomic, assign) CGPoint frameOrigin;
/** assignable shortcut form self.frame.size */
@property (nonatomic, assign) CGSize frameSize;
/** assignable shortcut for self.frame.size.width */
@property (nonatomic, assign) CGFloat frameWidth;
/** assignable shortcut for self.frame.size.height */
@property (nonatomic, assign) CGFloat frameHeight;
/** assignable shortcut for self.frame.origin.x */
@property (nonatomic, assign) CGFloat frameLeft;
/** assignable shortcut for self.frame.origin.y */
@property (nonatomic, assign) CGFloat frameTop;
/** assignable shortcut for self.frame.origin.y + self.frame.size.height */
@property (nonatomic, assign) CGFloat frameBottom;
/** assignable shortcut for self.frame.origin.x + self.frame.size.width */
@property (nonatomic, assign) CGFloat frameRight;
/** shortcut for self.bounds.size.width */
@property (nonatomic, readonly) CGFloat boundsWidth;
/** shortcut for self.bounds.size.height */
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

- (void)positionToLeftOfView:(UIView *)view;
- (void)positionToLeftOfView:(UIView *)view padding:(CGFloat)padding;
- (void)positionToLeftOfView:(UIView *)view alignment:(FKUIViewAlignment)alignment;
- (void)positionToLeftOfView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment;

/**
 Adds the subview to current view and centers it
 @param subview the view to add as centered subview
 */
- (void)addCenteredSubview:(UIView *)subview;
/**
 Centers the view within it's superview
 */
- (void)moveToCenterOfSuperview;

/**
 Sets a border on the view's layer with the specified width and color. The cornerRadius is set to 0.
 @param borderWidth the width of the border
 @param borderColor the color of the border
 */
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 Sets a border on the view's layer with the specified width, color and cornerRadius.
 @param borderWidth the width of the border
 @param borderColor the color of the border
 @param cornerRadius the radius of the border
 */
- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
/**
 Sets a shadow on the view's layer with the specified offset, radius and opacity
 @param offset the offset of the shadow
 @param radius the radius of the shadow
 @param opacity the opacity of the shadow
 */
- (void)setShadowWithOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;
/**
 Adds a linear gradientLayer as a sublayer on the current view's layer with the specified start- and endColor
 @param startColor the color used at the top of the view
 @param endColor the color used at the bottom of the view
 */
- (void)setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/**
 Sets a border on the view's layer with the specified color and a width of 2pt, if we are in Debug-Mode.
 Does nothing otherwise.
 @param color the color of the border
 */
- (void)enableDebugBorderWithColor:(UIColor *)color;
/**
 Sets a border on the view's layer with a random color and a width of 2pt, if we are in Debug-Mode.
 Does nothing otherwise.
 */
- (void)enableDebugBorderWithRandomColor;
/**
 Sets a border on the view's layer with an orange color and a width of 2pt, if we are in Debug-Mode.
 Does nothing otherwise.
 */
- (void)enableDebugBorder;

/**
 Returns an image representation of the current view
 @return a UIImage with the contents of the view
 */
- (UIImage *)imageRepresentation;

/**
 Recursively sets the property 'scrollsToTop' to NO for all subviews of the given view.
 
 @param view the view, which subviews should not scrollToTop
 */
+ (void)disableScrollsToTopOnAllSubviewsOfView:(UIView *)view;

/**
 Calls + disableScrollsToTopOnAllSubviewsView: with self.
 */
- (void)disableScrollsToTopOnAllSubviews;

/**
 Removes all gesture recognizers that are attached to the view
 */
- (void)removeAllGestureRecognizers;

@end
