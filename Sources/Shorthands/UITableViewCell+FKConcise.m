#import "UITableViewCell+FKConcise.h"
#import "UIView+FKHierarchy.h"

FKLoadCategory(UITableViewCellFKConcise);

@implementation UITableViewCell (FKConcise)

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle {
    NSString *cellID = [NSString stringWithFormat:@"%@_%d", [self cellIdentifier], cellStyle];
    return [self cellForTableView:tableView style:cellStyle reuseIdentifier:cellID];
}

+ (id)cellForTableView:(UITableView *)tableView style:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)reuseIdentifier {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:cellStyle reuseIdentifier:reuseIdentifier];
    }
    
    return cell; 
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
////////////////////////////////////////////////////////////////////////

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Properties
////////////////////////////////////////////////////////////////////////

- (UITableView *)tableView {
    return (UITableView *)[self superviewWithClass:[UITableView class]];
}

@end
