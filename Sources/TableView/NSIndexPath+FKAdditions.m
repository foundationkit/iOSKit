#import "NSIndexPath+FKAdditions.h"

@implementation NSIndexPath (FKAdditions)

+ (NSArray *)indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section {
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger row = startRow; row <= endRow; row++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    
    return [indexPaths copy];
}

@end
