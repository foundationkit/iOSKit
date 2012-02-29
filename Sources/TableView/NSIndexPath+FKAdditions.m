#import "NSIndexPath+FKAdditions.h"

FKLoadCategory(NSIndexPathFKAdditions);

@implementation NSIndexPath (FKAdditions)

+ (NSArray *)indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section {
    FKAssert(endRow >= startRow, @"endRow must be greater or equal than startRow");
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:endRow-startRow+1];
    
    for (NSInteger row = startRow; row <= endRow; row++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    
    return [indexPaths copy];
}

+ (NSIndexPath *)indexPathForFirstRowInSection:(NSInteger)section {
    return [self indexPathForRow:0 inSection:section];
}

@end
