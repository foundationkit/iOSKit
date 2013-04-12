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

- (void)addChildViewController:(UIViewController *)childController andRemoveOldChildViewController:(UIViewController *)oldChildController {
    if (childController != oldChildController && childController.parentViewController != self) {
        // Remove old childVC
        [oldChildController willMoveToParentViewController:nil];
        [oldChildController.view removeFromSuperview];
        [oldChildController removeFromParentViewController];

        // Add new childVC
        [self addChildViewController:childController];

        // Add view to hierarchy
        [self.view addSubview:childController.view];
        [childController didMoveToParentViewController:self];
    }
}

@end
