// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds a very DRY method for dequeuing/creating TableViewCells.
 It automatically takes care whether an exisiting cell can be dequeued or a
 new one has to be created.
 */

@interface UITableViewCell (FKConcise)

/** The tableView (superview) the cell is displayed in */
@property (nonatomic, readonly) UITableView *tableView;

/** The cell identifier of this UITableViewCell (sub-)class, equals the class name */
+ (NSString *)cellIdentifier;

/**
 Returns either a newly created cell, or a reused one with the cellIdentifier of the
 UITableViewCell (sub-)class and the given style. Different cellStyles lead to different
 reuse identifiers.
 
 @param tableView the tableView that is used for dequeing reusable cells
 @param cellStyle the UITableViewCellStyle of the cell
 @return a newly created or dequeued cell
 */
+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle;

/**
 Returns either a newly created cell, or a reused one with the specified reuseIdentifier.
 
 @param tableView the tableView that is used for dequeing reusable cells
 @param cellStyle the UITableViewCellStyle of the cell
 @param reuseIdentifier the identifier specified for dequeing reusable cells
 @return a newly created or dequeued cell
 */
+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)reuseIdentifier;

@end
