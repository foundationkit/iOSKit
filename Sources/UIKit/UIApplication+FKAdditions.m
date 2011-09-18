#import "UIApplication+FKAdditions.h"

@implementation UIApplication (FKAdditions)

- (BOOL)isPirated {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
}

@end
