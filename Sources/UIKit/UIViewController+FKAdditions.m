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

- (void)addChildViewController:(UIViewController *)childController andRemoveOldChildViewController:(UIViewController *)oldChildController callAppearanceMethods:(BOOL)callAppearanceMethods {
    if (childController != oldChildController && childController.parentViewController != self) {
        // Remove old childVC
        if (oldChildController != nil) {
            if (callAppearanceMethods) [oldChildController beginAppearanceTransition:NO animated:NO];
            [oldChildController willMoveToParentViewController:nil];
            [oldChildController.view removeFromSuperview];
            [oldChildController removeFromParentViewController];
            if (callAppearanceMethods) [oldChildController endAppearanceTransition];
        }

        // Add new childVC
        if (childController != nil) {
            if (callAppearanceMethods) [childController beginAppearanceTransition:YES animated:NO];
            [self addChildViewController:childController];
            [self.view addSubview:childController.view];
            [childController didMoveToParentViewController:self];
            if (callAppearanceMethods) [childController endAppearanceTransition];
        }
    }
}

@end
