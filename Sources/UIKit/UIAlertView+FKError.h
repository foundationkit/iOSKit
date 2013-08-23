// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds convenience-constructors, to create UIAlertViews based on NSError-Objects.
 */

@interface UIAlertView (FKError)

+ (UIAlertView *)fkit_alertViewWithError:(NSError *)error;
+ (UIAlertView *)fkit_alertViewWithDetailedError:(NSError *)error;

@end
