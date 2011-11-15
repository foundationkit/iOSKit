#import "UITableView+FKConcise.h"

@implementation UITableView (FKConcise)

- (void)deselectSelectedRowAnimated:(BOOL)animated {
    [self deselectRowAtIndexPath:self.indexPathForSelectedRow animated:animated];
}

@end
