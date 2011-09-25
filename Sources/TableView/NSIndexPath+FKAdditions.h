// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>

/**
 This category adds various additions to NSIndexPath for making life easier.
 */

@interface NSIndexPath (FKAdditions)

+ (NSArray *)indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section;

@end
