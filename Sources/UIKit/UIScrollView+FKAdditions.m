#import "UIScrollView+FKAdditions.h"

FKLoadCategory(UIScrollViewFKAdditions);

@implementation UIScrollView (FKAdditions)

- (BOOL)fkit_isAtBottom {
    return self.contentOffset.y + self.frame.size.height >= self.contentSize.height;
}

- (CGRect)fkit_visibleRect {
    CGRect visibleRect = (CGRect){.origin = self.contentOffset, .size = self.bounds.size};
    CGFloat theScale = 1.f / self.zoomScale;
    
    visibleRect.origin.x *= theScale;
    visibleRect.origin.y *= theScale;
    visibleRect.size.width *= theScale;
    visibleRect.size.height *= theScale;
    
    return visibleRect;
}

- (void)fkit_scrollToTop {
	[self fkit_scrollToTopAnimated:NO];
}

- (void)fkit_scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.f, -self.contentInset.top) animated:animated];
}

- (void)fkit_setContentAndScrollIndicatorInset:(UIEdgeInsets)contentInset {
    self.contentInset = contentInset;
    self.scrollIndicatorInsets = contentInset;
}

@end
