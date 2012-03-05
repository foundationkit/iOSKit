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
 Applys UIEdgeInsets to a CGRect.
 */
NS_INLINE CGRect FKRectInset(CGRect rect, UIEdgeInsets insets) {
    return UIEdgeInsetsInsetRect(rect, insets);
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
 Translates the origin of a rect by creating a new origin (origin.x+point.x, origin.y+point.y)
 */
NS_INLINE CGRect FKRectAddPoint(CGRect rect, CGPoint point) {
	return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}

/**
 Returns the center-point of a CGRect
 */
NS_INLINE CGPoint FKRectCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

////////////////////////////////////////////////////////////////////////
#pragma mark - CGSize Helper
////////////////////////////////////////////////////////////////////////

/**
 Scales a size to another size by keeping the aspect ratio
 */
NS_INLINE CGSize FKSizeAspectScaleToSize(CGSize size, CGSize toSize) {
	CGFloat aspect = 1.f;
    
	if (size.width > toSize.width) {
		aspect = toSize.width / size.width;
	}
    
	if (size.height > toSize.height) {
		aspect = MIN(toSize.height / size.height, aspect);
	}
    
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
