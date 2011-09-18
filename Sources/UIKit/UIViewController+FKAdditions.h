// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIViewController (FKAdditions)

+ (id)viewController;

- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)string;

@end
