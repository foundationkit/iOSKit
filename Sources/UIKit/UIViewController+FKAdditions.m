#import "UIViewController+FKAdditions.h"
#import "UIAlertView+FKError.h"

FKLoadCategory(UIViewControllerFKAdditions);

@implementation UIViewController (FKAdditions)

+ (id)viewController {
    return [[[self class] alloc] initWithNibName:nil bundle:nil];
}

- (BOOL)isViewVisible {
    return [self isViewLoaded] && self.view.window != nil;
}

- (void)displayDebugError:(NSError *)error {
#ifdef FK_DEBUG
	if (error == nil) {
		return;
	}
    
    UIAlertView *alertView = [UIAlertView alertViewWithError:error];
    [alertView show];
#endif
}

- (void)displayDetailedDebugError:(NSError *)error {
#ifdef FK_DEBUG
	if (error == nil) {
		return;
	}
    
    UIAlertView *alertView = [UIAlertView alertViewWithDetailedError:error];
    [alertView show];
#endif
}

- (void)displayDebugErrorString:(NSString *)string {
#ifdef FK_DEBUG
	if (string == nil || [string isBlank]) {
		return;
	}
    
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                    message:string 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
	[alert show];
#endif
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
