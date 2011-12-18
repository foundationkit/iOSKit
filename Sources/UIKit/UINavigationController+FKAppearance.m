#import "UINavigationController+FKAppearance.h"
#import "FKCompatibility.h"

static NSMutableArray *appearanceStack = nil;

/**
 Internal class used for representing an appearance snapshot
 */
@interface FKAppearanceSnapshot : NSObject {
    BOOL navigationBarTranslucent;
    BOOL navigationBarHidden;
    UIBarStyle navigationBarStyle;
    UIStatusBarStyle statusBarStyle;
    UIImage *backgroundImageDefault;
    UIImage *backgroundImageLandscape;
    NSDictionary *titleTextAttributes;
}

+ (FKAppearanceSnapshot *)snapshotFromNavigationController:(UINavigationController *)navigationController;

- (void)applyToNavigationController:(UINavigationController *)navigationController animated:(BOOL)animated;

@end


@implementation UINavigationController (FKAppearance)

+ (NSUInteger)appearanceStyleCount {
    return appearanceStack.count;
}

+ (void)removeAllAppearanceStyles {
    [appearanceStack removeAllObjects];
    appearanceStack = nil;
}

- (void)pushAppearanceStyle {
    if (appearanceStack == nil) {
        appearanceStack = [[NSMutableArray alloc] init];
    }
    
    FKAppearanceSnapshot *snapshot = [FKAppearanceSnapshot snapshotFromNavigationController:self];
    [appearanceStack addObject:snapshot];
}

- (void)popAppearanceStyle {
    [self popAppearanceStyleAnimated:YES];
}

- (void)popAppearanceStyleAnimated:(BOOL)animated {
    FKAssert([UINavigationController appearanceStyleCount] > 0, @"There is no appearance snapshot to pop.");
    
    if ([UINavigationController appearanceStyleCount] > 0) {
        FKAppearanceSnapshot *snapshot = [appearanceStack firstObject];
        [snapshot applyToNavigationController:self animated:animated];
        [appearanceStack removeObject:snapshot];
    }
    
    if ([UINavigationController appearanceStyleCount] == 0) {
        appearanceStack = nil;
    }
}

@end


@implementation FKAppearanceSnapshot

+ (FKAppearanceSnapshot *)snapshotFromNavigationController:(UINavigationController *)navigationController {
    FKAppearanceSnapshot *snapshot = [[FKAppearanceSnapshot alloc] init];
    
    snapshot->navigationBarTranslucent = navigationController.navigationBar.translucent;
    snapshot->navigationBarHidden = navigationController.navigationBarHidden;
    snapshot->navigationBarStyle = navigationController.navigationBar.barStyle;
    snapshot->statusBarStyle = [UIApplication sharedApplication].statusBarStyle;
    
    IF_IOS5_OR_GREATER
    (
     snapshot->backgroundImageDefault = [navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
     snapshot->backgroundImageLandscape = [navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsLandscapePhone];
     snapshot->titleTextAttributes = navigationController.navigationBar.titleTextAttributes;
     )
    
    return snapshot;
}

- (void)applyToNavigationController:(UINavigationController *)navigationController animated:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:animated];
    navigationController.navigationBarHidden = navigationBarHidden;
    navigationController.navigationBar.barStyle = navigationBarStyle;
    navigationController.navigationBar.translucent = navigationBarTranslucent;
    
    IF_IOS5_OR_GREATER
    (
     [navigationController.navigationBar setBackgroundImage:backgroundImageDefault forBarMetrics:UIBarMetricsDefault];
     [navigationController.navigationBar setBackgroundImage:backgroundImageLandscape forBarMetrics:UIBarMetricsLandscapePhone];
     [navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
     )
}

@end