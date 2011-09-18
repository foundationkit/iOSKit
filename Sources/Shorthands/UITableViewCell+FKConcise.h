// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UITableViewCell (FKConcise)

+ (NSString *)cellIdentifier;
+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle;

@end
