// Part of iOSKit http://foundationk.it

#import "UITextView+FKAdditions.h"

@implementation UITextView (FKAdditions)

- (void) sizeToFitNeededHeight {
	CGRect f = self.frame;

	f.size.height = self.contentSize.height;
	self.frame = f;
}

@end
