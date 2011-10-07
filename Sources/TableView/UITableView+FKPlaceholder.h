// Part of iOSKit http://foundationk.it
//
// Inspired by enormego's BSD-Licensed cocoa-helpers: http://github.com/enormego/cocoa-helpers

#import <UIKit/UIKit.h>
#import "FKiOSInternal.h"

@protocol FKTableViewPlaceholder;

/**
 This category adds Placeholder-Support to UITableView. 
 You can display a view as a placeholder, if the tableView has no data to show.
 */

@interface UITableView (FKPlaceholder)

/** 
 This method shows/hides the placeholder that is used to display any "No Content" - information.
 
 @param hidden flag to control the visiblity of the placeholderView
 */
- (void)setContentUnavailableViewHidden:(BOOL)hidden;

@end


@protocol FKTableViewPlaceholder <NSObject>

- (UIView *)contentUnavailableViewForTableView:(UITableView *)tableView;

@end