#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+FKContentSize.h"
#import "UIView+FKContentSize.h"

FKLoadCategory(UIScrollViewFKContentSize);

#define kFKDefaultPadding 2.f


BOOL FKViewIsScrollIndicator(UIView *view);
BOOL FKViewUseForAutocalculation(UIView *view);
CGPoint FKGetMaxPositions(UIScrollView *scrollView);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollView+FKContentSize
////////////////////////////////////////////////////////////////////////

@implementation UIScrollView (FKContentSize)

- (void)autocalculateContentHeight {
	[self autocalculateContentHeightWithPadding:kFKDefaultPadding];
}

- (void)autocalculateContentHeightWithPadding:(CGFloat)padding {
	CGFloat maxHeight = FKGetMaxPositions(self).y;
    
    self.contentSize = CGSizeMake(self.bounds.size.width, maxHeight + padding);
}

- (void)autocalculateContentWidth {
    [self autocalculateContentWidthWithPadding:kFKDefaultPadding];
}

- (void)autocalculateContentWidthWithPadding:(CGFloat)padding {
    CGFloat maxWidth = FKGetMaxPositions(self).x;
    
    self.contentSize = CGSizeMake(maxWidth + padding, self.bounds.size.height);
}

- (void)autocalculateContentSize {
    [self autocalculateContentSizeWithPadding:CGSizeMake(kFKDefaultPadding, kFKDefaultPadding)];
}

- (void)autocalculateContentSizeWithPadding:(CGSize)padding {
    CGPoint maxPositions = FKGetMaxPositions(self);
    
    self.contentSize = CGSizeMake(maxPositions.x+padding.width, maxPositions.y+padding.height); 
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

CGPoint FKGetMaxPositions(UIScrollView *scrollView) {
    NSArray *subviews = scrollView.subviews;
	CGPoint max = CGPointZero;
    
    // calculate max position of any subview of the scrollView
	for (UIView *view in subviews) {
        if (FKViewUseForAutocalculation(view)) {
            CGFloat maxXOfView = CGRectGetMaxX(view.frame);
            CGFloat maxYOfView = CGRectGetMaxY(view.frame);
            
            max.x = MAX(max.x, maxXOfView);
            max.y = MAX(max.y, maxYOfView);
        }
	}
    
    return max;
}