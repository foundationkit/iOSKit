#import "UITableViewCell+FKAdditions.h"


@implementation UITableViewCell (FKAdditions)

- (void)fkit_setSelectedBackgroundColor:(UIColor *)backgroundColor {
    UIView *backgroundView = self.selectedBackgroundView;

    if (backgroundView == nil || ![backgroundView isMemberOfClass:[UIView class]]) {
        backgroundView = [UIView new];

        self.selectedBackgroundView = backgroundView;
    }

    backgroundView.frame = self.bounds;
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.backgroundColor = backgroundColor;
}

@end
