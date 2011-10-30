// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>
#import "FKColoredCellSelectionView.h"
#import "UITableViewCell+FKLoading.h"

/**
 This class can be used as a base-class for grouped UITableViewCells that need a custom selection-gradient.
 */
@interface FKGroupedTableViewCell : UITableViewCell

/** The custom-colored selectionView */
@property (nonatomic, strong) FKColoredCellSelectionView *selectionView;

/** The start-color of the selection-gradient */
@property (nonatomic, readonly) UIColor *selectionGradientStartColor;
/** The end-color of the selection-gradient */
@property (nonatomic, readonly) UIColor *selectionGradientEndColor;

/**
 This method updates the position of the selectionView to display the right rounded corners.
 */
- (void)updatePosition;

@end
