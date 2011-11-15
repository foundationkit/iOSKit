// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various shortcuts to UITableView for making life easier.
 */
@interface UITableView (FKConcise)

/**
 This method deselects the currently selected row (with indexPath: indexPathForSelectedRow).
 
 @param animated Flag whether the deselection occurs animated or not
 */
- (void)deselectSelectedRowAnimated:(BOOL)animated;

@end
