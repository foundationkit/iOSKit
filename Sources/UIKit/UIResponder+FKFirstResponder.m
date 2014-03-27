#import "UIResponder+FKFirstResponder.h"


static __weak id currentFirstResponder;


@implementation UIResponder (FKFirstResponder)

+ (id)fkit_currentFirstResponder {
    currentFirstResponder = nil;

    // sending to nil sends the action to the first responder
    [[UIApplication sharedApplication] sendAction:@selector(fkit_findFirstResponder:) to:nil from:nil forEvent:nil];

    return currentFirstResponder;
}

- (void)fkit_findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end