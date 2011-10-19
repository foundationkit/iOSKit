// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIViewController for making life easier.
 You get a DRY method for creating a viewController without XIB, as well as checking
 if the view is currently visible and debugging-methods for displaying UIAlertViews from 
 NSErrors/NSStrings.
 */

@interface UIViewController (FKAdditions)

/** checks if the view of the viewController is currently visible */
@property (nonatomic, readonly, getter = isViewVisible) BOOL viewVisible;

+ (id)viewController;

/**
 This method is for testing purposes only. If we are in debug-mode it displays 
 a UIAlertView with a short description of the given error, nothing otherwise.
 
 @param error the error to display
 */
- (void)displayDebugError:(NSError *)error;

/**
 This method is for testing purposes only. If we are in debug-mode it displays 
 a UIAlertView with a detailed description of the given error, nothing otherwise.
 
 @param error the error to display
 */
- (void)displayDetailedDebugError:(NSError *)error;

/**
 This method is for testing purposes only, it displays a UIAlertView with
 the given error-string, if we are in Debug-Mode and does nothing otherwise.
 
 @param string the error string to display
 */
- (void)displayDebugErrorString:(NSString *)string;

/**
 Returns the currently visible viewController. If the viewController this method gets called on is
 a UITabBarController it returns the currently selected viewController, if the viewController is a
 UINavigationController is returns the topmost viewController in the navigation-stack. If the viewController
 is no Container-ViewController, it just returns self.
 
 @return the currently visible viewcontroller
 */
- (id)currentVisibleViewController;

@end
