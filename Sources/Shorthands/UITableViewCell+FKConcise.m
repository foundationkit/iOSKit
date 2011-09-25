#import "UITableViewCell+FKConcise.h"
#import "UIView+FKHierarchy.h"

FKLoadCategory(UITableViewCellFKConcise);

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

- (UITableView *)tableView {
    return (UITableView *)[self superviewWithClass:[UITableView class]];
}

@end
