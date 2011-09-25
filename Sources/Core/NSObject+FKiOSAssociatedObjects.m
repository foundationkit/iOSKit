#import "NSObject+FKiOSAssociatedObjects.h"
#import "NSValue+FKiOSConcise.h"

FKLoadCategory(NSObjectFKiOSAssociatedObjects);

@implementation NSObject (FKiOSAssociatedObjects)

- (void)associateRect:(CGRect)rect withKey:(void *)key {
    [self associateValue:$rect(rect) withKey:key];
}

- (void)associatePoint:(CGPoint)point withKey:(void *)key {
    [self associateValue:$point(point) withKey:key];
}

- (void)associateSize:(CGSize)size withKey:(void *)key {
    [self associateValue:$size(size) withKey:key];
}

@end
