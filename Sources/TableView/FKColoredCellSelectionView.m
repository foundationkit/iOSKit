#import "FKColoredCellSelectionView.h"
#import "FKiOSDrawing.h"

#define kFKDefaultMargin        10.f

@implementation FKColoredCellSelectionView

$synthesize(position);
$synthesize(gradientStartColor);
$synthesize(gradientEndColor);
$synthesize(lineWidth);
$synthesize(lineColor);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
        gradientStartColor_ = [UIColor whiteColor];
        gradientEndColor_ = [UIColor colorWithRed:0.8667 green:0.8667 blue:0.8667 alpha:1.0000];
        lineWidth_ = 1.f;
        lineColor_ = [UIColor grayColor];
	}
    
	return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (BOOL) isOpaque {
	return NO;
}

-(void)drawRect:(CGRect)aRect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGRect rect = self.bounds;
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
	CGGradientRef gradientRef = FKCreateGradientWithColors($array(self.gradientStartColor, self.gradientEndColor));
	CGContextSetStrokeColorWithColor(c, self.lineColor.CGColor);
	CGContextSetLineWidth(c, self.lineWidth);
	CGContextSetAllowsAntialiasing(c, YES);
	CGContextSetShouldAntialias(c, YES);
    CGMutablePathRef path = CGPathCreateMutable();
    
	if (self.position == FKCellBackgroundViewPositionTop) {
		CGPathMoveToPoint(path, NULL, minx, maxy);
		CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, kFKDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, maxy, kFKDefaultMargin);
		CGPathAddLineToPoint(path, NULL, maxx, maxy);
		CGPathAddLineToPoint(path, NULL, minx, maxy);
		CGPathCloseSubpath(path);
        
		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);
        
		CGContextDrawLinearGradient(c, gradientRef, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);
        
		CGContextAddPath(c, path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);
        
	} else if (self.position == FKCellBackgroundViewPositionBottom) {
		miny -= 1.f;
        
		CGPathMoveToPoint(path, NULL, minx, miny);
		CGPathAddArcToPoint(path, NULL, minx, maxy, midx, maxy, kFKDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, maxy, maxx, miny, kFKDefaultMargin);
		CGPathAddLineToPoint(path, NULL, maxx, miny);
		CGPathAddLineToPoint(path, NULL, minx, miny);
		CGPathCloseSubpath(path);
        
		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);
        
		CGContextDrawLinearGradient(c, gradientRef, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);
        
		CGContextAddPath(c, path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);
	} else if (self.position == FKCellBackgroundViewPositionMiddle) {
        miny -= 1.f;
        
		CGPathMoveToPoint(path, NULL, minx, miny);
		CGPathAddLineToPoint(path, NULL, maxx, miny);
		CGPathAddLineToPoint(path, NULL, maxx, maxy);
		CGPathAddLineToPoint(path, NULL, minx, maxy);
		CGPathAddLineToPoint(path, NULL, minx, miny);
		CGPathCloseSubpath(path);
        
		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);
        
		CGContextDrawLinearGradient(c, gradientRef, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);
        
		CGContextAddPath(c, path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);
        
	} else if (self.position == FKCellBackgroundViewPositionSingle) {
		CGPathMoveToPoint(path, NULL, minx, midy);
		CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, kFKDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, kFKDefaultMargin);
		CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, kFKDefaultMargin);
		CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, kFKDefaultMargin);
		CGPathCloseSubpath(path);
        
		// Fill and stroke the path
		CGContextSaveGState(c);
		CGContextAddPath(c, path);
		CGContextClip(c);
        
		CGContextDrawLinearGradient(c, gradientRef, CGPointMake(minx,miny), CGPointMake(minx,maxy), 0);
        
		CGContextAddPath(c, path);
		CGContextStrokePath(c);
		CGContextRestoreGState(c);
	}
    
    CGPathRelease(path);
	CGGradientRelease(gradientRef);
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark FKColoredCellSelectionView
////////////////////////////////////////////////////////////////////////

- (void)setPosition:(FKCellBackgroundViewPosition)position {
	if (position_ != position) {
		position_ = position;
		[self setNeedsDisplay];
	}
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth_ != lineWidth) {
        lineWidth_ = lineWidth;
        [self setNeedsDisplay];
    }
}

- (void)setLineColor:(UIColor *)lineColor {
    if (lineColor_ != lineColor) {
        lineColor_ = lineColor;
        [self setNeedsDisplay];
    }
}

@end
