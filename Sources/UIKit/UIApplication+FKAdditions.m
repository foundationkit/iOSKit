#import "UIApplication+FKAdditions.h"

FKLoadCategory(UIApplicationFKAdditions);

@implementation UIApplication (FKAdditions)

- (BOOL)isPirated {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
}

@end
