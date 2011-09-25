// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds a very DRY method for dequeuing/creating TableViewCells.
 It automatically takes care whether an exisiting cell can be dequeued or a
 new one has to be created.
 */

@interface UITableViewCell (FKConcise)

@property (nonatomic, readonly) UITableView *tableView;

+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle;

@end
