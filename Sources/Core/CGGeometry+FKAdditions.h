// Part of iOSKit http://foundationk.it
//
// Partly derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit
// Partly derived from jverkoys' Nimbus-Project: http://github.com/jverkoy/nimbus

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CGRect Helper
////////////////////////////////////////////////////////////////////////

NS_INLINE CGRect FKRectWithClearedOrigin(CGRect rect) {
    return CGRectMake(0.f,0.f,rect.size.width, rect.size.height);
}

NS_INLINE CGRect FKRectInset(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(CGRectGetMinX(rect)+insets.left, CGRectGetMinY(rect)+insets.top,
                      CGRectGetWidth(rect)-insets.left-insets.right, CGRectGetHeight(rect)-insets.top-insets.bottom);
}

NS_INLINE CGRect FKRectSetX(CGRect rect, CGFloat x) {
	return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

NS_INLINE CGRect FKRectSetY(CGRect rect, CGFloat y) {
	return CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
}

NS_INLINE CGRect FKRectSetWidth(CGRect rect, CGFloat width) {
	return CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height);
}

NS_INLINE CGRect FKRectSetHeight(CGRect rect, CGFloat height) {
	return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
}

NS_INLINE CGRect FKRectSetOrigin(CGRect rect, CGPoint origin) {
	return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}

NS_INLINE CGRect FKRectSetSize(CGRect rect, CGSize size) {
	return CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}

NS_INLINE CGRect FKRectAddPoint(CGRect rect, CGPoint point) {
	return CGRectMake(rect.origin.x + point.x, rect.origin.y + point.y, rect.size.width, rect.size.height);
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CGSize Helper
////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CGAffineTransform Helper
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
