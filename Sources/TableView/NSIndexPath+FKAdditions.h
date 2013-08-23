// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>

/**
 This category adds various additions to NSIndexPath for making life easier.
 */

@interface NSIndexPath (FKAdditions)

/**
 This method returns an array of indexPaths in the same section.
 The row index starts with startRow (including) end ends with endRow (including).
 
 @param startRow the row-index to start
 @param endRow the row-index to end
 @param section the section index of the indexPaths
 @return an array of indexPaths in the given section, starting from startRow to endRow
 */
+ (NSArray *)fkit_indexPathsFromRow:(NSInteger)startRow toRow:(NSInteger)endRow inSection:(NSInteger)section;

/*
 This method is a shortcut for [NSIndexPath indexPathForRow:0 inSection:section].
 
 @param section the section we want the indexPath of the first row of
 @return the indexPath for row 0 in the given section
 */
+ (NSIndexPath *)fkit_indexPathForFirstRowInSection:(NSInteger)section;

/*
 This method is a shortcut for [NSIndexPath indexPathForRow:row inSection:0].

 @param row the row of the index path
 @return the indexPath for the row "row" in the section 0
 */
+ (NSIndexPath *)fkit_indexPathForRowInFirstSection:(NSInteger)row;

@end
