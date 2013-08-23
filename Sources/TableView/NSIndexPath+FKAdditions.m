#import "NSIndexPath+FKAdditions.h"

FKLoadCategory(NSIndexPathFKAdditions);

@implementation NSIndexPath (FKAdditions)

+ (NSArray *)fkit_indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section {
    FKAssert(endRow >= startRow, @"endRow must be greater or equal than startRow");
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:(NSUInteger)(endRow-startRow+1)];
    
    for (NSInteger row = startRow; row <= endRow; row++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    
    return [indexPaths copy];
}

+ (NSIndexPath *)fkit_indexPathForFirstRowInSection:(NSInteger)section {
    return [self indexPathForRow:0 inSection:section];
}

+ (NSIndexPath *)fkit_indexPathForRowInFirstSection:(NSInteger)row {
    return [self indexPathForRow:row inSection:0];
}

@end
