#import "UITouch+FKCentroid.h"


CGPoint FKCentroidOfTouchesInView(NSSet *touches, UIView *view) {
    CGFloat sumX = 0.f;
    CGFloat sumY = 0.f;

    for (UITouch *touch in touches) {
        FKAssert([touch isKindOfClass:[UITouch class]], @"Touches must be a set of UITouch objects");

        CGPoint location = [touch locationInView:view];
        sumX += location.x;
        sumY += location.y;
    }

    return CGPointMake((CGFloat)round(sumX / touches.count), (CGFloat)round(sumY / touches.count));
}
