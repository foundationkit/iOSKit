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

/**
 Returns a viewController with nibName = nil and bundle = nil
 
 @return a new viewController without nib and bundle
 */
+ (id)viewController;

/**
 Returns a viewController with nibName = [self className] and bundle = nil
 
 @return a new viewController with a self-named nib and bundle = nil
 */
+ (id)viewControllerFromSelfNamedNib;

/**
 Returns the currently visible viewController. If the viewController this method gets called on is
 a UITabBarController it returns the currently selected viewController, if the viewController is a
 UINavigationController is returns the topmost viewController in the navigation-stack. If the viewController
 is no Container-ViewController, it just returns self.
 
 @return the currently visible viewcontroller
 */
- (id)currentVisibleViewController;

/**
 Shortcut method for iOS ViewController containment API
 */
- (void)addChildViewController:(UIViewController *)childController andRemoveOldChildViewController:(UIViewController *)oldChildController callAppearanceMethods:(BOOL)callAppearanceMethods;

@end
