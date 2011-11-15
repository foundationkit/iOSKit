#import "UITableView+FKConcise.h"

@implementation UITableView (FKConcise)

- (void)setContentAndScrollIndicatorInset:(UIEdgeInsets)contentInset {
    self.contentInset = contentInset;
    self.scrollIndicatorInsets = contentInset;
}

- (void)deselectSelectedRowAnimated:(BOOL)animated {
    [self deselectRowAtIndexPath:self.indexPathForSelectedRow animated:animated];
}

@end
