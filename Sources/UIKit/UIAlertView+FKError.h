// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds convenience-constructors, to create UIAlertViews based on NSError-Objects.
 */

@interface UIAlertView (FKError)

+ (UIAlertView *)alertViewWithError:(NSError *)error;
+ (UIAlertView *)alertViewWithDetailedError:(NSError *)error;

@end
