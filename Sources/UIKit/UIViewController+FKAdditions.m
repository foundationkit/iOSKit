#import "UIViewController+FKAdditions.h"

@implementation UIViewController (FKAdditions)

+ (id)viewController {
    return [[[self class] alloc] initWithNibName:nil bundle:nil];
}

@end
