#import "UIViewController+FKAdditions.h"
#import "UIAlertView+FKError.h"

FKLoadCategory(UIViewControllerFKAdditions);

@implementation UIViewController (FKAdditions)

+ (id)viewController {
    return [[[self class] alloc] initWithNibName:nil bundle:nil];
}

+ (id)viewControllerFromSelfNamedNib {
    return [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (BOOL)isViewVisible {
    return [self isViewLoaded] && self.view.window != nil;
}

- (id)currentVisibleViewController {
    if ([self isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)self;
        return [tabBarController.selectedViewController currentVisibleViewController];
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self;
        return [[navigationController visibleViewController] currentVisibleViewController];
    }
    
    return self;
}

@end
