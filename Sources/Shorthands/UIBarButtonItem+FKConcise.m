#import "UIBarButtonItem+FKConcise.h"

@implementation UIBarButtonItem (FKConcise)

+ (UIBarButtonItem *)fkit_flexibleSpaceItem {
    return [[[self class] alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

+ (UIBarButtonItem *)fkit_spaceItemWithWidth:(CGFloat)width {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    barButtonItem.width = width;
    
    return barButtonItem;
}

@end
