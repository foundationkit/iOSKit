// Part of iOSKit http://foundationk.it
// 
// Partly based on Enormego Cocoa Helpers by Shaun Harrison.
// Partly based on Three20 Framework by Facebook.

#import <UIKit/UIKit.h>

/**
 This category adds support for easy coping with UIView-Hierarchies.
 */

@interface UIView (FKHierarchy)

@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, readonly) NSInteger subviewIndex;

- (UIView *)superviewWithClass:(Class)aClass;                        // strict:NO
- (UIView *)superviewWithClass:(Class)aClass strict:(BOOL)strict;

- (UIView *)descendantOrSelfWithClass:(Class)aClass;                 // strict:NO
- (UIView *)descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict;

- (void)removeAllSubviews;

- (void)bringToFront;
- (void)sendToBack;

- (void)bringOneLevelUp;
- (void)sendOneLevelDown;

- (BOOL)isInFront;
- (BOOL)isAtBack;

- (void)swapDepthsWithView:(UIView*)swapView;

@end
