// Part of iOSKit http://foundationk.it

#import <QuartzCore/QuartzCore.h>
#import "UIView+FKAdditions.h"
#import "UIColor+FKAdditions.h"
#import "FKLog.h"

@implementation UIView (FKAdditions)

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Frame/Bounds
////////////////////////////////////////////////////////////////////////

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


- (void)setFrameWidth:(CGFloat)width {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setFrameHeight:(CGFloat)height {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setFrameTop:(CGFloat)top {
	self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameLeft:(CGFloat)left {
	self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameBottom:(CGFloat)bottom {
	self.frame = CGRectMake(self.frame.origin.x,bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setFrameRight:(CGFloat)right {
	self.frame = CGRectMake(right - self.frame.size.width,self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameHeight {
	return self.frame.size.height;
}

- (CGFloat)frameWidth {
	return self.frame.size.width;
}

- (CGFloat)frameTop {
	return self.frame.origin.y;
}

- (CGFloat)frameLeft {
	return self.frame.origin.x;
}

- (CGFloat)frameBottom {
	return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)frameRight {
	return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)boundsWidth {
    return self.bounds.size.width;
}

- (CGFloat)boundsHeight {
    return self.bounds.size.height;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Relative Positioning
////////////////////////////////////////////////////////////////////////

- (void)positionUnderView:(UIView *)view {
	[self positionUnderView:view padding:0];
}

- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding {
	[self positionUnderView:view padding:padding alignment:FKUIViewAlignmentUnchanged];
}

- (void)positionUnderView:(UIView *)view alignment:(FKUIViewAlignment)alignment {
	[self positionUnderView:view padding:0 alignment:alignment];
}

- (void)positionUnderView:(UIView *)view padding:(CGFloat)padding alignment:(FKUIViewAlignment)alignment {
	self.frameTop = view.frameBottom + padding;
    
	switch (alignment) {
		case FKUIViewAlignmentUnchanged:
			// do nothing
			break;
		case FKUIViewAlignmentLeftAligned:
			self.frameLeft = view.frameLeft;
			break;
            
		case FKUIViewAlignmentRightAligned:
			self.frameRight = view.frameRight;
			break;
            
		case FKUIViewAlignmentCentered:
			self.centerX = view.centerX;
			break;
	}
}

- (void)addCenteredSubview:(UIView *)subview {
	[self addSubview:subview];
    [subview moveToCenterOfSuperview];
}

- (void)moveToCenterOfSuperview {
	self.center = CGPointMake(self.superview.boundsWidth/2.f, self.superview.boundsHeight/2.f);
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Shadows/Borders
////////////////////////////////////////////////////////////////////////

- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    [self setBorderWidth:borderWidth borderColor:borderColor cornerRadius:0.f];
}

- (void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius {
	CALayer *layer = self.layer;
    
	layer.masksToBounds = YES;
	layer.cornerRadius = cornerRadius;
	layer.borderWidth = borderWidth;
	layer.borderColor = [borderColor CGColor];
}

- (void)setShadowOffset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
    CALayer *layer = self.layer;
    
	layer.masksToBounds = NO;
	layer.shadowOffset = offset;
	layer.shadowRadius = radius;
	layer.shadowOpacity = opacity;
}

- (void)setGradientBackgroundWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
	CAGradientLayer *gradient = [CAGradientLayer layer];
    
	gradient.frame = self.bounds;
	gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    
	[self.layer insertSublayer:gradient atIndex:0];
}

- (void)enableDebugBorderWithColor:(UIColor *)color {
	NKLog(@"enable debug for view %@", self);
    
	self.layer.borderColor = color.CGColor;
	self.layer.borderWidth = 2.0;
}

- (void)enableDebugBorderWithRandomColor {
	[self enableDebugBorderWithColor:[UIColor randomColor]];
}

- (void)enableDebugBorder {
	[self enableDebugBorderWithColor:[UIColor orangeColor]];
}


@end
