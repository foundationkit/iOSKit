#import "UIViewController+FKAdditions.h"

@implementation UIViewController (FKAdditions)

+ (id)viewController {
    return [[[self class] alloc] initWithNibName:nil bundle:nil];
}

- (void)displayError:(NSError *)error {
	if (!error) {
		return;
	}
    
	[self displayErrorString:[error localizedDescription]];
}


- (void)displayErrorString:(NSString *)string {
	if (!string || [string length] < 1) {
		return;
	}
    
#ifdef FK_DEBUG
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                    message:string 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
	[alert show];
#endif
}

@end
