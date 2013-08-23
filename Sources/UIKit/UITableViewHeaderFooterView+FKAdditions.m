#import "UITableViewHeaderFooterView+FKAdditions.h"

@implementation UITableViewHeaderFooterView (FKAdditions)

+ (NSString *)fkit_reuseIdentifier {
    return NSStringFromClass([self class]);
}


@end
