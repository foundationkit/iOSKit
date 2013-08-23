#import "UITableViewCell+FKLoading.h"

FKLoadCategory(UITableViewCellFKLoading);

static char activityViewKey;
static char previousAccessoryKey;

@interface UITableViewCell ()

// re-define as read/write
@property (nonatomic, strong, readwrite, setter = fkit_setActivityView:) UIActivityIndicatorView *fkit_activityView;
@property (nonatomic, strong) UIView *fk_previousAccessory;

@end

@implementation UITableViewCell (FKLoading)

- (void)fkit_showLoadingIndicator {
    if ([self.accessoryView isKindOfClass:[UIActivityIndicatorView class]]) {
        return;
    }
    
    // store previous accessoryView
    self.fk_previousAccessory = self.accessoryView;
    
    // set activityIndicator as new accessoryView
    self.fkit_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.fkit_activityView startAnimating];
    
    self.accessoryView = self.fkit_activityView;
}

- (void)fkit_showLoadingIndicatorWithColor:(UIColor *)color {
    [self fkit_showLoadingIndicator];
    self.fkit_activityView.color = color;
}

- (void)fkit_hideLoadingIndicator {
    if (self.fkit_activityView != nil) {
        [self.fkit_activityView stopAnimating];
        
        // restore previous state
        self.accessoryView = self.fk_previousAccessory;
        self.fkit_activityView = nil;
        self.fk_previousAccessory = nil;
    }
}

- (void)fkit_setActivityView:(UIActivityIndicatorView *)activityView {
    [self fkit_associateValue:activityView withKey:&activityViewKey];
}

- (UIActivityIndicatorView *)fkit_activityView {
    return (UIActivityIndicatorView *)[self fkit_associatedValueForKey:&activityViewKey];
}

- (void)setFk_previousAccessory:(UIView *)previousAccessory {
    [self fkit_associateValue:previousAccessory withKey:&previousAccessoryKey];
}

- (UIView *)fk_previousAccessory {
    return (UIView *)[self fkit_associatedValueForKey:&previousAccessoryKey];
}

@end
