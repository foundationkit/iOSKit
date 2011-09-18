// Part of iOSKit http://foundationk.it
//
// Derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

@interface UIScrollView (FKAdditions)

- (void)scrollToTop;    // animated = NO
- (void)scrollToTopAnimated:(BOOL)animated;

@end
