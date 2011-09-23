#import "UIViewController+FKAdditions.h"
#import "UIAlertView+FKError.h"
#import "NSString+FKAdditions.h"

@implementation UIViewController (FKAdditions)

+ (id)viewController {
    return [[[self class] alloc] initWithNibName:nil bundle:nil];
}

- (BOOL)isViewVisible {
    return [self isViewLoaded] && self.view.window != nil;
}

- (void)displayError:(NSError *)error {
#ifdef FK_DEBUG
	if (error == nil) {
		return;
	}
    
    UIAlertView *alertView = [UIAlertView alertViewWithError:error];
    [alertView show];
#endif
}

- (void)displayDetailedError:(NSError *)error {
#ifdef FK_DEBUG
	if (error == nil) {
		return;
	}
    
    UIAlertView *alertView = [UIAlertView alertViewWithDetailedError:error];
    [alertView show];
#endif
}

- (void)displayErrorString:(NSString *)string {
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

@end
