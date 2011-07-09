// Part of FoundationKit http://foundationk.it
//
// CGAffineTransform-helpers derived from http://iphonedevelopment.blogspot.com/2011/02/couple-cgaffinetransform-goodies.html

#import "NKMath.h"

NS_INLINE CGAffineTransform NKAffineTransformMakeRotateTranslate(CGFloat angle, CGFloat dx, CGFloat dy) {
    return CGAffineTransformMake(cosf(angle), sinf(angle), -sinf(angle), cosf(angle), dx, dy);
}

NS_INLINE CGAffineTransform NKAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy, CGFloat dx, CGFloat dy) {
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}