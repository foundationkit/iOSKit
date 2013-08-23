#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+FKContentSize.h"
#import "UIView+FKContentSize.h"

FKLoadCategory(UIScrollViewFKContentSize);

#define kFKDefaultPadding 2.f


BOOL FKViewUseForAutocalculation(UIView *view);
CGPoint FKGetMaxPositions(UIScrollView *scrollView);

////////////////////////////////////////////////////////////////////////
#pragma mark - UIScrollView+FKContentSize
////////////////////////////////////////////////////////////////////////

@implementation UIScrollView (FKContentSize)

- (void)fkit_autocalculateContentHeight {
	[self fkit_autocalculateContentHeightWithPadding:kFKDefaultPadding];
}

- (void)fkit_autocalculateContentHeightWithPadding:(CGFloat)padding {
	CGFloat maxHeight = FKGetMaxPositions(self).y;
    
    self.contentSize = CGSizeMake(self.bounds.size.width, maxHeight + padding);
}

- (void)fkit_autocalculateContentWidth {
    [self fkit_autocalculateContentWidthWithPadding:kFKDefaultPadding];
}

- (void)fkit_autocalculateContentWidthWithPadding:(CGFloat)padding {
    CGFloat maxWidth = FKGetMaxPositions(self).x;
    
    self.contentSize = CGSizeMake(maxWidth + padding, self.bounds.size.height);
}

- (void)fkit_autocalculateContentSize {
    [self fkit_autocalculateContentSizeWithPadding:CGSizeMake(kFKDefaultPadding, kFKDefaultPadding)];
}

- (void)fkit_autocalculateContentSizeWithPadding:(CGSize)padding {
    CGPoint maxPositions = FKGetMaxPositions(self);
    
    self.contentSize = CGSizeMake(maxPositions.x+padding.width, maxPositions.y+padding.height); 
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark - Helper Functions
////////////////////////////////////////////////////////////////////////

BOOL FKViewIsScrollIndicator(UIView *view) {
    static CGFloat scrollIndicatorWidth = 5.f;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (![UIView instancesRespondToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
            scrollIndicatorWidth = 7.f;
        }
    });

    // TODO: Is there a better way to detect the scrollIndicators?
    if ([view isKindOfClass:[UIImageView class]]) {
        if (CGRectGetHeight(view.frame) == scrollIndicatorWidth || CGRectGetWidth(view.frame) == scrollIndicatorWidth) {
            id image = [view performSelector:@selector(image)];
            
            if ([image isKindOfClass:NSClassFromString([NSString stringWithFormat:@"_%@Res%@le%@",@"UI", @"izab", @"Image"])]) {
                return YES;
            }
        }
    }
    
    return NO;
}

BOOL FKViewUseForAutocalculation(UIView *view) {
    return view.alpha > 0.f && view.hidden == NO && !FKViewIsScrollIndicator(view) && !view.fkit_excludedFromScrollViewAutocalculation;
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