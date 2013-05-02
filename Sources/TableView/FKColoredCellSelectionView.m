#import "FKColoredCellSelectionView.h"
#import "FKiOSDrawing.h"

#define kFKDefaultMargin        8.f

@implementation FKColoredCellSelectionView

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

+ (id)coloredSelectionViewForTableViewCell:(UITableViewCell *)cell {
    FKColoredCellSelectionView *selectionView = [[FKColoredCellSelectionView alloc] initWithFrame:cell.bounds];
    
    cell.selectedBackgroundView = selectionView;
    return selectionView;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
        _gradientStartColor = [UIColor whiteColor];
        _gradientEndColor = [UIColor colorWithRed:0.8667f green:0.8667f blue:0.8667f alpha:1.f];
        _lineWidth = 1.f;
        _lineColor = [UIColor grayColor];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	}
    
	return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (BOOL)isOpaque {
	return NO;
}

- (void)drawRect:(CGRect)aRect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGRect rect = self.bounds;
	CGFloat minx = CGRectGetMinX(rect);
    CGFloat midx = CGRectGetMidX(rect);
    CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
    CGFloat midy = CGRectGetMidY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
	CGGradientRef gradientRef = FKCreateGradientWithColors(@[self.gradientStartColor, self.gradientEndColor]);
	CGMutablePathRef path = CGPathCreateMutable();
    
	CGContextSetAllowsAntialiasing(c, YES);
	CGContextSetShouldAntialias(c, YES);
    CGContextSetStrokeColorWithColor(c, self.lineColor.CGColor);
    CGContextSetLineWidth(c, self.lineWidth);
    
	if (self.position == FKColoredCellSelectionViewPositionTop) {
        miny += 1.f;
        
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
        
	} else if (self.position == FKColoredCellSelectionViewPositionBottom) {
        miny -= 1.f;
        maxy -= 1.f;
        
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
	} else if (self.position == FKColoredCellSelectionViewPositionMiddle) {
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
        
	} else if (self.position == FKColoredCellSelectionViewPositionSingle) {
        miny += 1.f;
        maxy -= 1.f;
        
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
#pragma mark - FKColoredCellSelectionView
////////////////////////////////////////////////////////////////////////

- (void)setPosition:(FKColoredCellSelectionViewPosition)position {
	if (position != _position) {
		_position = position;
		[self setNeedsDisplay];
	}
}

- (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth != _lineWidth) {
        _lineWidth = lineWidth;
        [self setNeedsDisplay];
    }
}

- (void)setLineColor:(UIColor *)lineColor {
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        [self setNeedsDisplay];
    }
}

- (void)updatePositionForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSInteger sectionRows = [tableView numberOfRowsInSection:indexPath.section];
    NSInteger row = indexPath.row;

    // first and last row?
    if (row == 0 && row == sectionRows - 1) {
        [self setPosition:FKColoredCellSelectionViewPositionSingle];
    } 
    // first row?
    else if (row == 0) {
        [self setPosition:FKColoredCellSelectionViewPositionTop];
    } 
    // last row?
    else if (row == sectionRows - 1) {
        [self setPosition:FKColoredCellSelectionViewPositionBottom];
    } 
    // middle row.
    else {
        [self setPosition:FKColoredCellSelectionViewPositionMiddle];
    }
}

@end
