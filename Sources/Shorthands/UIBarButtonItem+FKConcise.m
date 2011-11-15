#import "UIBarButtonItem+FKConcise.h"

@implementation UIBarButtonItem (FKConcise)

+ (UIBarButtonItem *)flexibleSpaceItem {
    return [[[self class] alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end
