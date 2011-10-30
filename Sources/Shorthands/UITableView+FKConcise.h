// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various shortcuts to UITableView for making life easier.
 */
@interface UITableView (FKConcise)

/**
 This method sets the content inset for the tableView itself as well as for the scrollIndicator.
 
 @param contentInset The contentInset to set on the tableView and the scrollIndicators
 */
- (void)setContentAndScrollIndicatorInset:(UIEdgeInsets)contentInset;

@end
