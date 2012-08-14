// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>

@interface NSIndexSet (FKAdditions)

/**
 Creates an indexSet with the row attributes of all the given indexPaths.
 
 @param indexPaths an Array of NSIndexPath objects
 @return an index set
 */
+ (NSIndexSet *)indexSetWithRowsOfIndexPaths:(NSArray *)indexPaths;

@end
