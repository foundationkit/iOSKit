// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIViewController (FKLoading)

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;

- (void)showCenteredLoadingIndicator;
- (void)hideLoadingIndicator;

@end
