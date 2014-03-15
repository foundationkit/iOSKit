#import <QuartzCore/QuartzCore.h>
#import "UIView+FKAdditions.h"
#import "UIColor+FKAdditions.h"
#import "CGGeometry+FKAdditions.h"

FKLoadCategory(UIViewFKAdditions);

@implementation UIView (FKAdditions)

////////////////////////////////////////////////////////////////////////
#pragma mark - Frame/Bounds
////////////////////////////////////////////////////////////////////////

- (void)setIntegralCenter:(CGPoint)integralCenter {
    self.center = integralCenter;
    self.frame = CGRectIntegral(self.frame);
}

- (CGPoint)integralCenter {
    return self.center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setIntegralFrame:(CGRect)integralFrame {
    self.frame = CGRectIntegral(integralFrame);
}

- (CGRect)integralFrame {
    return CGRectIntegral(self.frame);
}

- (void)setFrameOrigin:(CGPoint)frameOrigin {
    self.frame = FKRectSetOrigin(self.frame, frameOrigin);
}

- (CGPoint)frameOrigin {
    return self.frame.origin;
}

- (void)setFrameSize:(CGSize)frameSize {
    self.frame = FKRectSetSize(self.frame, frameSize);
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameWidth:(CGFloat)width {
    self.frame = FKRectSetWidth(self.frame, width);
}

- (void)setFrameHeight:(CGFloat)height {
    self.frame = FKRectSetHeight(self.frame, height);
}

- (void)setFrameTop:(CGFloat)top {
    self.frame = FKRectSetY(self.frame, top);
}

- (void)setFrameLeft:(CGFloat)left {
    self.frame = FKRectSetX(self.frame, left);
}

- (void)setFrameBottom:(CGFloat)bottom {
	self.frame = CGRectMake(self.frame.origin.x,bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameRight:(CGFloat)right {
	self.frame = CGRectMake(right - self.frame.size.width,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameHeight {
	return CGRectGetHeight(self.frame);
}

- (CGFloat)frameWidth {
	return CGRectGetWidth(self.frame);
}

- (CGFloat)frameTop {
	return CGRectGetMinY(self.frame);
}

- (CGFloat)frameLeft {
	return CGRectGetMinX(self.frame);
}

- (CGFloat)frameBottom {
	return CGRectGetMaxY(self.frame);
}

- (CGFloat)frameRight {
	return CGRectGetMaxX(self.frame);
}

- (CGFloat)boundsWidth {
    return CGRectGetWidth(self.bounds);
}

- (CGFloat)boundsHeight {
    return CGRectGetHeight(self.bounds);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Relative Positioning
////////////////////////////////////////////////////////////////////////

- (void)fkit_positionUnderView:(UIView *)view {
	[self fkit_positionUnderView:view padding:0.f];
}

- (void)fkit_positionUnderView:(UIView *)view padding:(CGFloat)padding {
	[self fkit_positionUnderView:view padding:padding alignment:FKUIViewAlignmentUnchanged];
}

- (void)fkit_positionUnderView:(UIView *)view alignment:(FKUIViewAlignment)alignment {
	[self fkit_positionUnderView:view padding:0.f alignment:alignment];
}

- (void)fkit_positionUnderView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment {
	self.frameTop = view.frameBottom + padding;
    
	switch (alignment) {
		case FKUIViewAlignmentLeftAligned:
			self.frameLeft = view.frameLeft;
			break;
            
		case FKUIViewAlignmentRightAligned:
			self.frameRight = view.frameRight;
			break;
            
		case FKUIViewAlignmentCentered:
			self.centerX = view.centerX;
			break;
            
        case FKUIViewAlignmentUnchanged:
        case FKUIViewAlignmentTopAligned:
        case FKUIViewAlignmentBottomAligned:
        default:
			// do nothing
			break;
	}
}

- (void)fkit_positionNextToView:(UIView *)view {
	[self fkit_positionNextToView:view padding:0.f];
}

- (void)fkit_positionNextToView:(UIView *)view padding:(CGFloat)padding {
	[self fkit_positionNextToView:view padding:padding alignment:FKUIViewAlignmentUnchanged];
}

- (void)fkit_positionNextToView:(UIView *)view alignment:(FKUIViewAlignment)alignment {
	[self fkit_positionNextToView:view padding:0.f alignment:alignment];
}

- (void)fkit_positionNextToView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment {
	self.frameLeft = view.frameRight + padding;
    
	switch (alignment) {
		case FKUIViewAlignmentTopAligned:
			self.frameTop = view.frameTop;
			break;
            
		case FKUIViewAlignmentBottomAligned:
			self.frameBottom = view.frameBottom;
			break;
            
		case FKUIViewAlignmentCentered:
			self.centerY = view.centerY;
			break;
            
        case FKUIViewAlignmentUnchanged:
        case FKUIViewAlignmentLeftAligned:
        case FKUIViewAlignmentRightAligned:
        default:
			// do nothing
			break;
	}
}

- (void)fkit_positionToLeftOfView:(UIView *)view {
	[self fkit_positionToLeftOfView:view padding:0.f];
}

- (void)fkit_positionToLeftOfView:(UIView *)view padding:(CGFloat)padding {
	[self fkit_positionToLeftOfView:view padding:padding alignment:FKUIViewAlignmentUnchanged];
}

- (void)fkit_positionToLeftOfView:(UIView *)view alignment:(FKUIViewAlignment)alignment {
	[self fkit_positionNextToView:view padding:0.f alignment:alignment];
}

- (void)fkit_positionToLeftOfView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment {
	self.frameRight = view.frameLeft - padding;

	switch (alignment) {
		case FKUIViewAlignmentTopAligned:
			self.frameTop = view.frameTop;
			break;

		case FKUIViewAlignmentBottomAligned:
			self.frameBottom = view.frameBottom;
			break;

		case FKUIViewAlignmentCentered:
			self.centerY = view.centerY;
			break;

        case FKUIViewAlignmentUnchanged:
        case FKUIViewAlignmentLeftAligned:
        case FKUIViewAlignmentRightAligned:
        default:
			// do nothing
			break;
	}
}

- (void)fkit_addCenteredSubview:(UIView *)subview {
	[self addSubview:subview];
    [subview fkit_moveToCenterOfSuperview];
}

- (void)fkit_moveToCenterOfSuperview {
	self.center = CGPointMake(self.superview.boundsWidth/2.f, self.superview.boundsHeight/2.f);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Shadows/Borders
////////////////////////////////////////////////////////////////////////

- (void)fkit_setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    [self fkit_setBorderWidth:borderWidth borderColor:borderColor cornerRadius:0.f];
}

- (void)fkit_setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius {
	CALayer *layer = self.layer;
    
	layer.masksToBounds = YES;
	layer.cornerRadius = cornerRadius;
	layer.borderWidth = borderWidth;
	layer.borderColor = [borderColor CGColor];
}

- (void)fkit_setShadowWithOffset:(CGSize)offset radius:(CGFloat)radius opacity:(float)opacity {
    CALayer *layer = self.layer;
    
	layer.masksToBounds = NO;
	layer.shadowOffset = offset;
	layer.shadowRadius = radius;
	layer.shadowOpacity = opacity;
}

- (void)fkit_setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
	CAGradientLayer *gradient = [CAGradientLayer layer];
    
	gradient.frame = self.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    
	[self.layer insertSublayer:gradient atIndex:0];
}

- (void)fkit_enableDebugBorderWithColor:(UIColor *)color {
    FKLogDebug(@"[Enabling debug border for view %@]", self);
    
#ifdef FK_DEBUG
    [self fkit_setBorderWidth:2.f borderColor:color];
#endif
}

- (void)fkit_enableDebugBorderWithRandomColor {
	[self fkit_enableDebugBorderWithColor:[UIColor randomColor]];
}

- (void)fkit_enableDebugBorder {
	[self fkit_enableDebugBorderWithColor:[UIColor orangeColor]];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Gestures
////////////////////////////////////////////////////////////////////////

- (void)fkit_removeAllGestureRecognizers {
    for (UIGestureRecognizer *gestureRecognizer in self.gestureRecognizers) {
        [self removeGestureRecognizer:gestureRecognizer];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Image Representation
////////////////////////////////////////////////////////////////////////

- (UIImage *)fkit_imageRepresentation {
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.f);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    return image;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Scrolling
////////////////////////////////////////////////////////////////////////

+ (void)fkit_disableScrollsToTopOnAllSubviewsOfView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)subview).scrollsToTop = NO;
        }
        
        [self fkit_disableScrollsToTopOnAllSubviewsOfView:subview];
    }
}

- (void)fkit_disableScrollsToTopOnAllSubviews {
    [UIView fkit_disableScrollsToTopOnAllSubviewsOfView:self];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Parallax
////////////////////////////////////////////////////////////////////////

- (void)fkit_addParallaxEffectWithMaxOffset:(CGFloat)maxOffset; {
    UIInterpolatingMotionEffect *parallaxEffectX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                   type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    UIInterpolatingMotionEffect *parallaxEffectY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                   type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];

    parallaxEffectX.minimumRelativeValue = @(-maxOffset);
    parallaxEffectX.maximumRelativeValue = @(maxOffset);

    parallaxEffectY.minimumRelativeValue = parallaxEffectX.minimumRelativeValue;
    parallaxEffectY.maximumRelativeValue = parallaxEffectX.maximumRelativeValue;

    UIMotionEffectGroup *effectGroup = [[UIMotionEffectGroup alloc] init];
    effectGroup.motionEffects = @[parallaxEffectX, parallaxEffectY];

    [self addMotionEffect:effectGroup];
}

@end
