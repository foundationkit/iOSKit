#import "UIView+FKContentSize.h"

FKLoadCategory(UIViewFKContentSize);

static char excludedKey;

@implementation UIView (FKContentSize)

- (BOOL)excludedFromScrollViewAutocalculation {
    NSNumber *excluded = (NSNumber *)[self associatedValueForKey:&excludedKey];
    
    if (excluded != nil) {
        return [excluded boolValue];
    }
    
    return NO;
}

- (void)setExcludedFromScrollViewAutocalculation:(BOOL)excludedFromScrollViewAutocalculation {
    [self associateValue:$bool(excludedFromScrollViewAutocalculation) withKey:&excludedKey];
}

@end
