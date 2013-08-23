// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds support to UIViewController for displaying activityIndicators in various places.
 You can either display the activityIndicator centered, in the navigation bar (as a replacement for the
 rightBarButtonItem) or instead of a given view. The activityView is constrained in it's size and doesn't
 get bigger than UIActivityIndicatorStyleWhiteLarge (37 pt). Hidden Views/BarButtonItems get restored, as
 soon as the activityIndicator gets hidden.
 
 @see UITableView+FKLoading
 @see UITableViewCell+FKLoading
 */

@interface UIViewController (FKLoading)

/** The activityView that is displayed while loading. Can be customized */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *fkit_activityView;

/**
 Shows the loading indicator centered in the viewController's view.
 */
- (void)fkit_showCenteredLoadingIndicator;

/**
 Shows the loading indicator at the given point with the specified autoresizingMask.
 
 @param center the center of the loading indicator
 @param autoresizingMask the autoresizingMask of the loading indicator
 */
- (void)fkit_showLoadingIndicatorAtPoint:(CGPoint)center autoresizingMask:(UIViewAutoresizing)autoresizingMask;

/**
 Shows the loading indicator instead of the given view. The view gets hidden and the 
 activityIndicator gets the same autoresizingMask as the view that was replaced. When
 the activityIndicator gets hidden, the view gets shown again.
 
 @param viewToReplace the view that gets hidden while showing the activity indicator
 */
- (void)fkit_showLoadingIndicatorInsteadOfView:(UIView *)viewToReplace;

/**
 Shows the loading indicator on top of the given view. The activityIndicator gets the same 
 autoresizingMask as the view it is shown on top of. Since the size of the loading indicator
 is constrained to 37 pt it is centered in the view, if the view is bigger than 37*37 pt.
 
 @param view the view that is used to determine the position of the loading indicator
 */
- (void)fkit_showLoadingIndicatorOnTopOfView:(UIView *)view;

/**
 Shows the loading indicator as the right bar button item in the navigationBar.
 */
- (void)fkit_showLoadingIndicatorInNavigationBar;

/**
 Shows the acitvityIndicator instead of the given item in the given toolbar.
 
 @param toolbar the toolbar that will hold the activityIndicator
 @param itemToReplace the item that gets hidden while the activityIndicator is shown
 */
- (void)fkit_showLoadingIndicatorInToolbar:(UIToolbar *)toolbar insteadOfItem:(UIBarButtonItem *)itemToReplace;

/**
 Hides the loading indicator and resets the view to the state before the indicator 
 was shown, e.g. shows a hidden view again, sets the rightBarButtonItem again or 
 resets the toolbar.
 */
- (void)fkit_hideLoadingIndicator;

@end
