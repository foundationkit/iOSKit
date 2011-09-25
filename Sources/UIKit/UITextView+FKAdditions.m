#import "UITextView+FKAdditions.h"

FKLoadCategory(UITextViewFKAdditions);

@implementation UITextView (FKAdditions)

- (void) sizeToFitNeededHeight {
	CGRect f = self.frame;

	f.size.height = self.contentSize.height;
	self.frame = f;
}

@end
