// Part of iOSKit http://foundationk.it
//
// Inspired by enormego's BSD-Licensed cocoa-helpers: http://github.com/enormego/cocoa-helpers

#import <UIKit/UIKit.h>
#import "FKiOSInternal.h"

@protocol FKTableViewPlaceholder;

@interface UITableView (FKPlaceholder)

@property (nonatomic, fk_weak) id<FKTableViewPlaceholder> placeholderDelegate;

- (void)setContentUnavailableViewHidden:(BOOL)hidden;

@end


@protocol FKTableViewPlaceholder <NSObject>

- (UIView *)contentUnavailableViewForTableView:(UITableView *)tableView;

@end