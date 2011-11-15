// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various shortcuts to UITableView for making life easier.
 */
@interface UITableView (FKConcise)

/**
 This method sets the content inset for the tableView itself as well as for the scrollIndicator.
 
 @param contentInset The contentInset to set on the tableView and the scrollIndicators
 */
- (void)setContentAndScrollIndicatorInset:(UIEdgeInsets)contentInset;

/**
 This method deselects the currently selected row (with indexPath: indexPathForSelectedRow).
 
 @param animated Flag whether the deselection occurs animated or not
 */
- (void)deselectSelectedRowAnimated:(BOOL)animated;

@end
