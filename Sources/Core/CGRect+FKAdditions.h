// Part of iOSKit http://foundationk.it


NS_INLINE CGRect FKRectWithClearedOrigin(CGRect rect) {
    return CGRectMake(0.f,0.f,rect.size.width, rect.size.height);
}

NS_INLINE CGRect FKRectInset(CGRect rect, UIEdgeInsets insets) {
    return CGRectMake(CGRectGetX(rect)+insets.left, CGRectGetY(rect)+insets.top,
                      CGRectGetWidth(rect)-insets.left-insets.right, CGRectGetHeight(rect)-insets.top-insets.bottom);
}