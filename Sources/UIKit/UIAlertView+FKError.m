#import "UIAlertView+FKError.h"

FKLoadCategory(UIAlertViewFKError);

@implementation UIAlertView (FKError)

+ (UIAlertView *)alertViewWithError:(NSError *)error {
    return [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error: %@",error.domain]
                                      message:[error localizedDescription]
                                     delegate:nil 
                            cancelButtonTitle:@"OK" 
                            otherButtonTitles:nil];
}

+ (UIAlertView *)alertViewWithDetailedError:(NSError *)error {
    NSArray *options = [error localizedRecoveryOptions];
	NSUInteger count = [options count];
	NSString *cancelTitle = @"OK";
    NSArray *otherButtons = nil;
    
	if (count > 0) {
        cancelTitle = [options objectAtIndex:0];
    }
    
	if (count > 1) {
		NSMutableArray *mutableOptions = [options mutableCopy];
		[mutableOptions removeObjectAtIndex:0];
		otherButtons = [mutableOptions copy];
	}	
    
	id alertView = [[self alloc] initWithTitle:[error domain]
									   message:[error localizedDescription]
									  delegate:nil
							 cancelButtonTitle:cancelTitle
							 otherButtonTitles:nil];
    
	for (NSString *s in otherButtons) {
		[alertView addButtonWithTitle:s];
    }
    
	return alertView;
}

@end
