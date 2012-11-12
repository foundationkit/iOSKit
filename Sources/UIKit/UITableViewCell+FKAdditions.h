// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UITableViewCell for making life easier.
 */
@interface UITableViewCell (FKAdditions)

/**
 Set the background color of the cell for the selected state.
 
 @param backgroundColor the color of the selectedBackgroundView
 */
- (void)setSelectedBackgroundColor:(UIColor *)backgroundColor;

@end
