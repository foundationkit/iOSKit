// Part of iOSKit http://foundationk.it
//
// Inspired by work of Andy Matuschak:
// https://github.com/andymatuschak/NSObject-AssociatedObjects

#import <Foundation/Foundation.h>

@interface NSObject (FKiOSAssociatedObjects)

- (void)associateRect:(CGRect)rect withKey:(void *)key;
- (void)associatePoint:(CGPoint)point withKey:(void *)key;
- (void)associateSize:(CGSize)size withKey:(void *)key;

@end
