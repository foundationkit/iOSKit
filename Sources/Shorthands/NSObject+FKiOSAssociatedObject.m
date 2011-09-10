// Part of FoundationKit http://foundationk.it
//
// Inspired by work of Andy Matuschak:
// https://github.com/andymatuschak/NSObject-AssociatedObjects

#import "NSObject+FKiOSAssociatedObject.h"
#import "NSObject+FKAssociatedObject.h"
#import "NSValue+FKiOSConcise.h"

@implementation NSObject (FKiOSAssociatedObject)

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
