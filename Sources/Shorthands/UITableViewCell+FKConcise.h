// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UITableViewCell (FKConcise)

@property (nonatomic, readonly) UITableView *tableView;

+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle;

@end
