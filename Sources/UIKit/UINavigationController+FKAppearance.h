// Part of iOSKit http://foundationk.it
// 
// Derived from jverkoeys Nimbus-Project: http://github.com/jverkoey/nimbus

#import <UIKit/UIKit.h>

/**
 Class for saving and restoring the navigation appearance state.
 You use this when you are about to mutate the navigation bar style and/or status
 bar style, and you want to be able to restore these bar styles sometime in the
 future.
  
 Note that the call to pushAppearanceStyle must occur before mutating any bar
 states so that it is able to capture the original state correctly.
 */

@interface UINavigationController (FKAppearance)

+ (NSUInteger)appearanceStyleCount;
+ (void)removeAllAppearanceStyles;

- (void)pushAppearanceStyle;
- (void)popAppearanceStyle; // animated = YES
- (void)popAppearanceStyleAnimated:(BOOL)animated;

@end
