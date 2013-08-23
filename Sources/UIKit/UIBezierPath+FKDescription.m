#import "UIBezierPath+FKDescription.h"


void CGPathEnumerationCallback(void *info, const CGPathElement *element);


@implementation UIBezierPath (FKDescription)

////////////////////////////////////////////////////////////////////////
#pragma mark - UIBezierPath+FKDescription
////////////////////////////////////////////////////////////////////////

- (void)fkit_enumerateElementsUsingBlock:(fk_bezierPath_block)handler {
    CGPathRef cgPath = self.CGPath;

    
    CGPathApply(cgPath, (__bridge_retained void*)([handler copy]), CGPathEnumerationCallback);
}

- (NSString *)fkit_pathDescription {
    CGPathRef cgPath = self.CGPath;
    CGRect bounds = CGPathGetPathBoundingBox(cgPath);
    CGRect controlPointBounds = CGPathGetBoundingBox(cgPath);

    NSMutableString *mutableDescription = [NSMutableString string];
    [mutableDescription appendFormat:@"%@ <%p>\n", [self class], self];
    [mutableDescription appendFormat:@"  Bounds: %@\n", NSStringFromCGRect(bounds)];
    [mutableDescription appendFormat:@"  Control Point Bounds: %@\n", NSStringFromCGRect(controlPointBounds)];

    [self fkit_enumerateElementsUsingBlock:^(const CGPathElement *element) {
        [mutableDescription appendFormat:@"    %@\n", [self fk_descriptionForPathElement:element]];
    }];

    return [mutableDescription copy];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (NSString *)fk_descriptionForPathElement:(const CGPathElement *)element {
    NSString *description = nil;
    
    switch (element->type) {
        case kCGPathElementMoveToPoint: {
            CGPoint point = element ->points[0];
            description = [NSString stringWithFormat:@"%f %f %@", point.x, point.y, @"moveto"];
            break;
        }
        case kCGPathElementAddLineToPoint: {
            CGPoint point = element ->points[0];
            description = [NSString stringWithFormat:@"%f %f %@", point.x, point.y, @"lineto"];
            break;
        }
        case kCGPathElementAddQuadCurveToPoint: {
            CGPoint point1 = element->points[0];
            CGPoint point2 = element->points[1];
            description = [NSString stringWithFormat:@"%f %f %f %f %@", point1.x, point1.y, point2.x, point2.y, @"quadcurveto"];
            break;
        }
        case kCGPathElementAddCurveToPoint: {
            CGPoint point1 = element->points[0];
            CGPoint point2 = element->points[1];
            CGPoint point3 = element->points[2];
            description = [NSString stringWithFormat:@"%f %f %f %f %f %f %@", point1.x, point1.y, point2.x, point2.y, point3.x, point3.y, @"curveto"];
            break;
        }
        case kCGPathElementCloseSubpath: {
            description = @"closepath";
            break;
        }
    }

    return description;
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark - Functions
////////////////////////////////////////////////////////////////////////

void CGPathEnumerationCallback(void *info, const CGPathElement *element) {
    fk_bezierPath_block handler = (__bridge_transfer fk_bezierPath_block)info;

    if (handler != nil) {
        handler(element);
    }
}
