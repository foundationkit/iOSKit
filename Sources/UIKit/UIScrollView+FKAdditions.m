#import "UIScrollView+FKAdditions.h"

FKLoadCategory(UIScrollViewFKAdditions);

@implementation UIScrollView (FKAdditions)

- (CGRect)visibleRect {
    CGRect visibleRect = (CGRect){.origin = self.contentOffset, .size = self.bounds.size};
    float theScale = 1.f / self.zoomScale;
    
    visibleRect.origin.x *= theScale;
    visibleRect.origin.y *= theScale;
    visibleRect.size.width *= theScale;
    visibleRect.size.height *= theScale;
    
    return visibleRect;
}

- (void)scrollToTop {
	[self scrollToTopAnimated:NO];
}

- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.f, 0.f) animated:animated];
}

- (void)setContentAndScrollIndicatorInset:(UIEdgeInsets)contentInset {
    self.contentInset = contentInset;
    self.scrollIndicatorInsets = contentInset;
}

@end
