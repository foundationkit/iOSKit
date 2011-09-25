// Part of iOSKit http://foundationk.it
//
// Derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIScrollView for making life easier.
 */

@interface UIScrollView (FKAdditions)

- (void)scrollToTop;    // animated = NO
- (void)scrollToTopAnimated:(BOOL)animated;

@end
