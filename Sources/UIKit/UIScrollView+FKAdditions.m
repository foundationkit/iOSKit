#import "UIScrollView+FKAdditions.h"

@implementation UIScrollView (FKAdditions)

- (void)scrollToTop {
	[self scrollToTopAnimated:NO];
}

- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.f, 0.f) animated:animated];
}

@end
