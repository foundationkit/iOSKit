// Part of iOSKit http://foundationk.it
//
// Partly derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit
// Partly derived from jverkoys' Nimbus-Project: http://github.com/jverkoy/nimbus

////////////////////////////////////////////////////////////////////////
#pragma mark - CGRect Helper
////////////////////////////////////////////////////////////////////////

/**
 Creates a new CGRect with (0.,0.) as it's origin, and the same width/height as the original CGRect
 */
NS_INLINE CGRect FKRectWithClearedOrigin(CGRect rect) {
    return CGRectMake(0.f,0.f,rect.size.width, rect.size.height);
}

/**
 Sets a new value for origin.x, leaves all other values unchanged.
 */
NS_INLINE CGRect FKRectSetX(CGRect rect, CGFloat x) {
	return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

/**
 Sets a new value for origin.y, leaves all other values unchanged.
 */
NS_INLINE CGRect FKRectSetY(CGRect rect, CGFloat y) {
	return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

/**
 Sets a new value for size.width, leaves all other values unchanged.
 */
NS_INLINE CGRect FKRectSetWidth(CGRect rect, CGFloat width) {
	return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

/**
 Sets a new value for size.height, leaves all other values unchanged.
 */
NS_INLINE CGRect FKRectSetHeight(CGRect rect, CGFloat height) {
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

/**
 Sets a new origin, leaves the size unchanged
 */
NS_INLINE CGRect FKRectSetOrigin(CGRect rect, CGPoint origin) {
	return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}

/**
 Sets a new size, leaves the origin unchanged
 */
NS_INLINE CGRect FKRectSetSize(CGRect rect, CGSize size) {
	return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}

/**
 Returns the center-point of a CGRect
 */
NS_INLINE CGPoint FKRectCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

NS_INLINE CGRect FKRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
    return CGRectMake(center.x - size.width/2.f, center.y - size.height/2.f, size.width, size.height);
}

// Taken from https://github.com/github/Archimedes
NS_INLINE CGRect CGRectFloor(CGRect rect) {
    return CGRectMake((CGFloat)floor(rect.origin.x), (CGFloat)floor(rect.origin.y), (CGFloat)floor(rect.size.width), (CGFloat)floor(rect.size.height));
}


////////////////////////////////////////////////////////////////////////
#pragma mark - CGSize Helper
////////////////////////////////////////////////////////////////////////

/**
 Scales a size to another size by keeping the aspect ratio
 */
NS_INLINE CGSize FKSizeAspectScaleToSize(CGSize size, CGSize toSize) {
	CGFloat aspect = 1.f;

	aspect = toSize.width / size.width;
	aspect = MIN(toSize.height / size.height, aspect);

	return CGSizeMake(size.width * aspect, size.height * aspect);
}

/**
 Creates a size that has integral width and height
 */
NS_INLINE CGSize FKSizeIntegral(CGSize size) {
    return CGSizeMake((CGFloat)round((double)size.width), 
                      (CGFloat)round((double)size.height));
}


////////////////////////////////////////////////////////////////////////
#pragma mark - CGPoint Helper
////////////////////////////////////////////////////////////////////////

/**
 Calculates the squared distance between two CGPoints
 */
NS_INLINE CGFloat FKSquaredDistanceBetweenCGPoints(CGPoint p1, CGPoint p2) {
    CGFloat dx = p1.x - p2.x;
    CGFloat dy = p1.y - p2.y;
    
    return dx*dx+dy*dy;
}

/**
 Calculates the distance between two CGPoints
 */
NS_INLINE CGFloat FKDistanceBetweenCGPoints(CGPoint p1, CGPoint p2) {
    return (CGFloat)sqrt((double)FKSquaredDistanceBetweenCGPoints(p1, p2));
}

/**
 Creates a point that has only integral coordinates
 */
NS_INLINE CGPoint FKPointIntegral(CGPoint point) {
    return CGPointMake((CGFloat)round((double)point.x), 
                       (CGFloat)round((double)point.y));
}

////////////////////////////////////////////////////////////////////////
#pragma mark - CGAffineTransform Helper
////////////////////////////////////////////////////////////////////////

/** 
 Creates an affine transform for the given device orientation.
 This is useful for creating a transformation matrix for a view that has been added
 directly to a UIWindow and doesn't automatically have its transformation modified.
 */

NS_INLINE CGAffineTransform FKRotationTransformForOrientation(UIInterfaceOrientation orientation) {
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation((CGFloat)(M_PI * 1.5));
        
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation((CGFloat)(M_PI / 2.0));
        
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation((CGFloat)(-M_PI));
        
    } else {
        return CGAffineTransformIdentity;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Rubber-Band simulation
////////////////////////////////////////////////////////////////////////

/**
 Simulates the UIScrollView rubber-band effect.
 x = (1.0 - (1.0 / ((x * c / d) + 1.0))) * d
 
 @param distanceWithoutRubberBand distance that can be moved without applying rubber-band effect
 @param distance  x: distance, from the edge.
 @param dimension d: dimension, either width or height.
 @param constant  c: constant, UIScrollView uses 0.55.

 https://twitter.com/chpwn/status/285540192096497664
 https://twitter.com/chpwn/status/285540396484923393
 */
__attribute__((overloadable)) NS_INLINE CGFloat FKRubberBandTranslation(CGFloat distanceWithoutRubberBand, CGFloat distance, CGFloat dimension, CGFloat constant) {
    if (distance <= distanceWithoutRubberBand) {
        return distance;
    }

    return distanceWithoutRubberBand + (1.f - (1.f / (((distance-distanceWithoutRubberBand) * constant / dimension) + 1.f))) * dimension;
}

__attribute__((overloadable)) NS_INLINE CGFloat FKRubberBandTranslation(CGFloat distanceWithoutRubberBand, CGFloat distance, CGFloat dimension) {
    return FKRubberBandTranslation(distanceWithoutRubberBand, distance, dimension, 0.55f);
}

__attribute__((overloadable)) NS_INLINE CGFloat FKRubberBandTranslation(CGFloat distance, CGFloat dimension) {
    return FKRubberBandTranslation(0.f, distance, dimension);
}
