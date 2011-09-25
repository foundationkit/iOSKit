// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds support to UITextview to automatically size it's height based on the contentSize.
 */

@interface UITextView (FKAdditions)

- (void)sizeToFitNeededHeight;

@end
