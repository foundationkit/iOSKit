#import "UIScreen+FKAdditions.h"
#import "UIApplication+FKConcise.h"

@implementation UIScreen (FKAdditions)

- (CGRect)currentBounds {
	return [self boundsForOrientation:$appOrientation];
}

- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation {
	CGRect bounds = [self bounds];
    
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		CGFloat buffer = bounds.size.width;
        
		bounds.size.width = bounds.size.height;
		bounds.size.height = buffer;
	}
	return bounds;
}

- (BOOL)isRetinaDisplay {
	static dispatch_once_t predicate;
	static BOOL answer;
    
	dispatch_once(&predicate, ^{
		answer = ([self respondsToSelector:@selector(scale)] && [self scale] == 2);
	});
    
	return answer;
}

@end
