// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds an easy way to UITableView to show loading indicators in UITableViewCells.
 
 @see UITableViewCell+FKLoading
 @see UIViewController+FKLoading
 */

@interface UITableView (FKLoading)

@property (nonatomic, assign) BOOL allowsMultipleLoadingIndicators;

- (void)showLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath;
- (void)hideLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath;
// hides all loading indicators
- (void)hideLoadingIndicators;

@end
