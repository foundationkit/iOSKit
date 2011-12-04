// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds support to UIViewController for displaying activityIndicators in various places.
 You can either display the activityIndicator centered, in the navigation bar (as a replacement for the
 rightBarButtonItem) or instead of a given view. The activityView is constrained in it's size and doesn't
 get bigger than UIActivityIndicatorStyleWhiteLarge (37 pt). Hidden Views/BarButtonItems get restored, as
 soon as the activityIndicator gets hidden again.
 
 @see UITableView+FKLoading
 @see UITableViewCell+FKLoading
 */

@interface UIViewController (FKLoading)

/** The activityView that is displayed while loading. Can be customized */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

/**
 Shows the loading indicator centered in the viewController's view.
 */
- (void)showCenteredLoadingIndicator;

/**
 Shows the loading indicator instead of the given view. The view gets hidden and the 
 activityIndicator gets the same autoresizingMask as the view that was replaced. When
 the activityIndicator gets hidden, the view gets shown again.
 
 @param viewToReplace the view that gets hidden while showing the activity indicator
 */
- (void)showLoadingIndicatorInsteadOfView:(UIView *)viewToReplace;

/**
 Shows the loading indicator as the right bar button item in the navigationBar.
 */
- (void)showLoadingIndicatorInNavigationBar;

/**
 Shows the acitvityIndicator instead of the given item in the given toolbar.
 
 @param toolbar the toolbar that will hold the activityIndicator
 @param itemToReplace the item that gets hidden while the activityIndicator is shown
 */
- (void)showLoadingIndicatorInToolbar:(UIToolbar *)toolbar insteadOfItem:(UIBarButtonItem *)itemToReplace;

/**
 Hides the loading indicator and resets the view to the state before the indicator 
 was shown, e.g. shows a hidden view again, sets the rightBarButtonItem again or 
 resets the toolbar.
 */
- (void)hideLoadingIndicator;

@end
