// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>

@interface NSIndexPath (FKAdditions)

+ (NSArray *)indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section;

@end
