// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIViewController for making life easier.
 You get a DRY method for creating a viewController without XIB, as well as checking
 if the view is currently visible and debugging-methods for displaying UIAlertViews from 
 NSErrors/NSStrings.
 */

@interface UIViewController (FKAdditions)

// is the view of the viewController currently visible
@property (nonatomic, readonly, getter = isViewVisible) BOOL viewVisible;

+ (id)viewController;

- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)string;

@end
