#import "UITableViewCell+FKAdditions.h"

@implementation UITableViewCell (FKAdditions)

- (void)fkit_setSelectedBackgroundColor:(UIColor *)backgroundColor {
    UIView *backgroundView = self.selectedBackgroundView;

    if (backgroundView == nil || ![backgroundView isMemberOfClass:[UIView class]]) {
        backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.selectedBackgroundView = backgroundView;
    }

    backgroundView.backgroundColor = backgroundColor;
}

@end
