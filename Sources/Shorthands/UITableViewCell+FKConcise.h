// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds a very DRY method for dequeuing/creating TableViewCells.
 It automatically takes care whether an exisiting cell can be dequeued or a
 new one has to be created.
 */

@interface UITableViewCell (FKConcise)

/** The tableView (superview) the cell is displayed in */
@property (nonatomic, readonly) UITableView *fkit_tableView;

/** The cell identifier of this UITableViewCell (sub-)class, equals the class name */
+ (NSString *)fkit_reuseIdentifier;

@end
