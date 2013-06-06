// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds an easy way to show an activity view in a UITableViewCell.
 The activity view is added as the accessory view. When the activity view gets hidden
 again, the previous accessory gets restored.
 
 NOTE: 
 Make sure to hide the activityView in your TableViewCells Implementation of
 - (void)prepareForReuse
 
 @see UITableView+FKLoading
 @see UIViewController+FKLoading
 @see FKTableViewCell
 */

@interface UITableViewCell (FKLoading)

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

- (void)showLoadingIndicator;
- (void)showLoadingIndicatorWithColor:(UIColor *)color;
- (void)hideLoadingIndicator;

@end
