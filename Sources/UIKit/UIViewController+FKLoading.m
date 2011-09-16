#import "UIViewController+FKLoading.h"
#import "NSObject+FKAssociatedObjects.h"

static char activityViewKey;

@interface UIViewController ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityView;

@end

@implementation UIViewController (FKLoading)

- (void)setActivityView:(UIActivityIndicatorView *)activityView {
    [self associateValue:activityView withKey:&activityViewKey];
}

- (UIActivityIndicatorView *)activityView {
    __block UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self associatedValueForKey:&activityViewKey];
    
    // create activityView when it is first read
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityView = activityView;
    }
    
    return activityView;
}

- (void)showCenteredLoadingIndicator {
    UIActivityIndicatorView *activityView = self.activityView;
    
    // center activityView
    CGRect activityFrame = activityView.frame; 
    
    activityFrame.origin.x = (self.view.bounds.size.width - activityFrame.size.width) / 2.;
    activityFrame.origin.y = (self.view.bounds.size.height - activityFrame.size.height) / 2.;
    
    activityView.frame = CGRectIntegral(activityFrame);
    activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    [self.view addSubview:activityView];
    [activityView startAnimating];
}

- (void)hideLoadingIndicator {
    UIActivityIndicatorView *activityView = self.activityView;
    
    [activityView stopAnimating];
    [activityView removeFromSuperview];
}

@end
