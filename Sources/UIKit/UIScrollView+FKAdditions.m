#import "UIScrollView+FKAdditions.h"

@implementation UIScrollView (FKAdditions)

- (void)scrollToTop {
	[self scrollToTopAnimated:NO];
}

- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.0f, 0.0f) animated:animated];
}

@end
