// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds an easy way to UITableView to show loading indicators in UITableViewCells.
 
 @see UITableViewCell+FKLoading
 @see UIViewController+FKLoading
 */

@interface UITableView (FKLoading)

@property (nonatomic, assign, setter = fkit_setAllowsMultipleLoadingIndicators:) BOOL fkit_allowsMultipleLoadingIndicators;

- (void)fkit_showLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath;
- (void)fkit_hideLoadingIndicatorAtIndexPath:(NSIndexPath *)indexPath;
// hides all loading indicators
- (void)fkit_hideLoadingIndicators;

@end
