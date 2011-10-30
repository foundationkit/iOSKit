#import "UITableView+FKConcise.h"

@implementation UITableView (FKConcise)

- (void)setContentAndScrollIndicatorInset:(UIEdgeInsets)contentInset {
    self.contentInset = contentInset;
    self.scrollIndicatorInsets = contentInset;
}

@end
