// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIViewController (FKAdditions)

// is the view of the viewController currently visible
@property (nonatomic, readonly, getter = isViewVisible) BOOL viewVisible;

+ (id)viewController;

- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)string;

@end
