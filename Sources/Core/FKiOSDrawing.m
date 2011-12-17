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

void FKDrawInsetBeveledRoundedRect(CGContextRef context, CGRect rect, CGFloat radius, UIColor *fillColor) {
    //contract the bounds of the rectangle in to account for the stroke
    CGRect drawRect = CGRectInset(rect, 1.0f, 1.0f);
    
	//contract the height by 1 to account for the white bevel at the bottom
    drawRect.size.height -= 1.0f;
    
    //Save the current state so we don't persist anything beyond this operation
	CGContextSaveGState(context);
    
    //Generate the rounded rectangle paths
    CGPathRef boxPath = [[UIBezierPath bezierPathWithRoundedRect: drawRect cornerRadius: radius] CGPath];
    //For the stroke, offset by half a pixel to ensure proper drawing
    CGPathRef strokePath = [[UIBezierPath bezierPathWithRoundedRect: CGRectInset(drawRect, -0.5f, -0.5f) cornerRadius: radius] CGPath];
    
    /*Draw the bevel effect*/
    CGContextSaveGState(context);
    //Set the color to be slightly transparent white
    CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite: 1.0f alpha: 0.8f] CGColor]);
    //Clip the region to only the visible portion to optimzie drawing
    CGContextClipToRect(context, CGRectMake(rect.origin.x, rect.origin.y+rect.size.height-radius, rect.size.width, radius));
    //draw the left corner curve
    CGRect corner = CGRectMake(rect.origin.x, (rect.origin.y+rect.size.height)-(2*radius)-1, (radius*2)+1, (radius*2)+1);
    CGContextFillEllipseInRect(context, corner);
    //draw the right corner
    corner.origin.x = rect.origin.x + rect.size.width - (radius*2)-1;
    CGContextFillEllipseInRect(context, corner);
    //draw the rectangle in the middle
    //set the blend mode to replace any existing pixels (or else we'll see visible overlap)
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextFillRect(context, CGRectMake(rect.origin.x+radius, rect.origin.y+rect.size.height-radius, rect.size.width-(2*radius),radius+1));
    CGContextRestoreGState(context);
    
    /*Draw the main region */
    CGContextSaveGState(context);
    //fill it with our colour of choice
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    //use the stroke path so the boundaries line up with the stroke (else we'll see a gap on retina devices)
    CGContextAddPath(context, strokePath);
    //fill it
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    /*Main fill region inner drop shadow*/
    /*(This is done by duplicating the path, offsetting the duplicate by 1 pixel, and using the EO winding fill rule to fill the gap between the two)*/
    CGContextSaveGState(context);
    //set the colour to be a VERY faint grey
    CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite: 0.0f alpha: 0.08f] CGColor]);
    //clip the shadow to the top of the box (to reduce overhead)
    CGContextClipToRect(context, CGRectMake( drawRect.origin.x, drawRect.origin.y, drawRect.size.width, radius ));
    //add the first instance of the path
    CGContextAddPath(context, boxPath);
    //translate the draw origin down by 1 pixel
    CGContextTranslateCTM(context, 0.0f, 1.0f);
    //add the second instance of the path
    CGContextAddPath(context, boxPath);
    //use the EO winding rule to fill the gap between the two paths
    CGContextEOFillPath(context);
    CGContextRestoreGState(context);
    
    /*Outer Stroke*/
    /*This is drawn outside of the fill region to prevent the fill region bleeding over in some cases*/
    CGContextSaveGState(context);
    //set the line width to be 1 pixel
    CGContextSetLineWidth(context, 1.0f);
    //set the the colour to be a very transparent shade of grey
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithWhite: 0.0f alpha: 0.18f] CGColor]);
    //set up the path to draw the stroke along
    CGContextAddPath(context, strokePath);
    //set the blending mode to replace underlying pixels on this layer (so the background will come through through)
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    //draw the path
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    //Restore the previous CG state
	CGContextRestoreGState(context);
}
