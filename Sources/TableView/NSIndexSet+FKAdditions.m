#import "NSIndexSet+FKAdditions.h"

@implementation NSIndexSet (FKAdditions)

+ (NSIndexSet *)indexSetWithRowsOfIndexPaths:(NSArray *)indexPaths {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    for (NSIndexPath *indexPath in indexPaths) {
        [indexSet addIndex:(NSUInteger)indexPath.row];
    }

    return indexSet;
}

@end
