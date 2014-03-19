// Part of iOSKit http://foundationk.it
// 
// Partly based on Enormego Cocoa Helpers by Shaun Harrison.
// Partly based on Three20 Framework by Facebook.

#import <UIKit/UIKit.h>

/**
 This category adds support for easy coping with UIView-Hierarchies.
 */

@interface UIView (FKHierarchy)

@property (nonatomic, readonly) UIViewController *fkit_viewController;

- (id)fkit_superviewWithClass:(Class)aClass;                        // strict:NO
- (id)fkit_superviewWithClass:(Class)aClass strict:(BOOL)strict;

- (id)fkit_descendantOrSelfWithClass:(Class)aClass;                 // strict:NO
- (id)fkit_descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict;

- (void)fkit_removeAllSubviews;

@end
