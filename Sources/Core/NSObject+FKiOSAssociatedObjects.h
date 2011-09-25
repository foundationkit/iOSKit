// Part of iOSKit http://foundationk.it
//
// Derived From Andy Matuschak's Public Domain-licensed NSObject-Category: https://github.com/andymatuschak/NSObject-AssociatedObjects

#import <Foundation/Foundation.h>

/**
 This category adds shortcuts for associating CGGeometry-structs with an object.
 */

@interface NSObject (FKiOSAssociatedObjects)

- (void)associateRect:(CGRect)rect withKey:(void *)key;
- (void)associatePoint:(CGPoint)point withKey:(void *)key;
- (void)associateSize:(CGSize)size withKey:(void *)key;

@end
