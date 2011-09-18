#import "UITableViewCell+FKConcise.h"

@implementation UITableViewCell (FKConcise)

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
    }
    
    return cell; 
}

@end
