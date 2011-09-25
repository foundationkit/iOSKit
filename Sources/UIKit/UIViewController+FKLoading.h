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

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

- (void)showCenteredLoadingIndicator;
- (void)showLoadingIndicatorInsteadOfView:(UIView *)viewToReplace;
- (void)showLoadingIndicatorInNavigationBar;
- (void)hideLoadingIndicator;

@end
