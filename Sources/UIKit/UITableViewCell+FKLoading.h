// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

// NOTE: 
// Make sure to hide the activityView in your TableViewCells Implementation of
// - (void)prepareForReuse

@interface UITableViewCell (FKLoading)

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;

@end
