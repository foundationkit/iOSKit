// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIAlertView (FKError)

+ (UIAlertView *)alertViewWithError:(NSError *)error;
+ (UIAlertView *)alertViewWithDetailedError:(NSError *)error;

@end
