#import "FKiOSDrawing.h"

CGGradientRef FKCreateGradientWithColors(NSArray *colors) {
	return FKCreateGradientWithColorsAndLocations(colors, nil);
}

CGGradientRef FKCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations) {
	NSUInteger colorsCount = colors.count;
    
	if (colorsCount < 2) {
		return nil;
	}
    
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors objectAtIndex:0] CGColor]);
    
	CGFloat *gradientLocations = NULL;
	NSUInteger locationsCount = [locations count];
	
    if (locationsCount == colorsCount) {
		gradientLocations = (CGFloat *)malloc(sizeof(CGFloat) * locationsCount);
        
        for (NSUInteger i = 0; i < locationsCount; i++) {
			gradientLocations[i] = [[locations objectAtIndex:i] floatValue];
		}
	}
    
	NSMutableArray *gradientColors = [[NSMutableArray alloc] initWithCapacity:colorsCount];
	[colors enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[gradientColors addObject:(id)[(UIColor *)object CGColor]];
	}];
    
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
	if (gradientLocations) {
		free(gradientLocations);
	}
    
	return gradient;
}

void FKDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect) {
	CGContextSaveGState(context);
	CGContextClipToRect(context, rect);
	CGPoint start = CGPointMake(rect.origin.x, rect.origin.y);
	CGPoint end = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
	CGContextDrawLinearGradient(context, gradient, start, end, 0);
	CGContextRestoreGState(context);
}


void FKDrawRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerRadius) {
	CGPoint min = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGPoint mid = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGPoint max = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
	CGContextMoveToPoint(context, min.x, mid.y);
	CGContextAddArcToPoint(context, min.x, min.y, mid.x, min.y, cornerRadius);
	CGContextAddArcToPoint(context, max.x, min.y, max.x, mid.y, cornerRadius);
	CGContextAddArcToPoint(context, max.x, max.y, mid.x, max.y, cornerRadius);
	CGContextAddArcToPoint(context, min.x, max.y, min.x, mid.y, cornerRadius);
    
	CGContextClosePath(context);
	CGContextFillPath(context);
}

