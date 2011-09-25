#import "UITableViewCell+FKLoading.h"

FKLoadCategory(UITableViewCellFKLoading);

static char activityViewKey;
static char previousAccessoryKey;

@interface UITableViewCell ()

// re-define as read/write
@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIView *fk_previousAccessory;

@end

@implementation UITableViewCell (FKLoading)

- (void)showLoadingIndicator {
    if ([self.accessoryView isKindOfClass:[UIActivityIndicatorView class]]) {
        return;
    }
    
    // store previous accessoryView
    self.fk_previousAccessory = self.accessoryView;
    
    // set activityIndicator as new accessoryView
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.activityView startAnimating];
    
    self.accessoryView = self.activityView;
}

- (void)hideLoadingIndicator {
    [self.activityView stopAnimating];
    
    // restore previous state
    self.accessoryView = self.fk_previousAccessory;
    self.activityView = nil;
    self.fk_previousAccessory = nil;
}

- (void)setActivityView:(UIActivityIndicatorView *)activityView {
    [self associateValue:activityView withKey:&activityViewKey];
}

- (UIActivityIndicatorView *)activityView {
    return (UIActivityIndicatorView *)[self associatedValueForKey:&activityViewKey];
}

- (void)setFk_previousAccessory:(UIView *)previousAccessory {
    [self associateValue:previousAccessory withKey:&previousAccessoryKey];
}

- (UIView *)fk_previousAccessory {
    return (UIView *)[self associatedValueForKey:&previousAccessoryKey];
}

@end
