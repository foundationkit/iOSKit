#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+FKContentSize.h"
#import "UIView+FKContentSize.h"

#define kFKDefaultPadding 5.f

typedef enum {
    FKOrientationHorizontal,
    FKOrientationVertical
} FKOrientation;

BOOL FKViewIsScrollIndicator(UIView *view);
BOOL FKViewUseForAutocalculation(UIView *view);
CGFloat FKGetMaxPosition(UIScrollView *scrollView, FKOrientation orientation);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollView+FKContentSize
////////////////////////////////////////////////////////////////////////

@implementation UIScrollView (FKContentSize)

- (void)autocalculateContentHeight {
	[self autocalculateContentHeightWithPadding:kFKDefaultPadding];
}

- (void)autocalculateContentHeightWithPadding:(CGFloat)padding {
	CGFloat maxHeight = FKGetMaxPosition(self, FKOrientationVertical);
    
    self.contentSize = CGSizeMake(self.bounds.size.width, maxHeight + padding);
}

- (void)autocalculateContentWidth {
    [self autocalculateContentWidthWithPadding:kFKDefaultPadding];
}

- (void)autocalculateContentWidthWithPadding:(CGFloat)padding {
    CGFloat maxWidth = FKGetMaxPosition(self, FKOrientationHorizontal);
    
    self.contentSize = CGSizeMake(maxWidth + padding, self.bounds.size.height);
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helper Functions
////////////////////////////////////////////////////////////////////////

BOOL FKViewIsScrollIndicator(UIView *view) {
    // TODO: Is there a better way to detect the scrollIndicators?
    if ([view isKindOfClass:[UIImageView class]]) {
        if (CGRectGetHeight(view.frame) == 7.f || CGRectGetWidth(view.frame) == 7.f) {
            if ([view.layer animationForKey:@"position"] != nil) {
                return YES;
            }
        }
    }
    
    return NO;
}

BOOL FKViewUseForAutocalculation(UIView *view) {
    return view.alpha > 0.f && view.hidden == NO && !FKViewIsScrollIndicator(view) && !view.excludedFromScrollViewAutocalculation;
}

CGFloat FKGetMaxPosition(UIScrollView *scrollView, FKOrientation orientation) {
    NSArray *subviews = scrollView.subviews;
	CGFloat max = -1.f;
    
    // calculate max position of any subview of the scrollView
	for (UIView *view in subviews) {
        if (FKViewUseForAutocalculation(view)) {
            CGFloat maxOfView = (orientation == FKOrientationVertical ? CGRectGetMaxY(view.frame) : CGRectGetMaxX(view.frame));
            
            if (maxOfView > max) {
                max = maxOfView;
            }
        }
	}
    
    return max;
}