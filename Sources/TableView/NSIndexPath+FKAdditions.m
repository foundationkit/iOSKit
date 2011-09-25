#import "NSIndexPath+FKAdditions.h"

FKLoadCategory(NSIndexPathFKAdditions);

@implementation NSIndexPath (FKAdditions)

+ (NSArray *)indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:endRow-startRow+1];
    
    for (NSInteger row = startRow; row <= endRow; row++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    
    return [indexPaths copy];
}

@end
