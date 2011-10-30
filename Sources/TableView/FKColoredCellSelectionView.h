// Part of iOSKit http://foundationk.it
//
// Derived by Matt Coneabeare's UACellBackgroundView: http://code.coneybeare.net/how-to-make-custom-drawn-gradient-backgrounds

#import <UIKit/UIKit.h>

/**
 To correctly draw the highlighting-gradient we have to know the position of the current cell.
 If it is top we have to draw rounded corners on top, respective for the other positions
 */
typedef enum  {
	FKColoredCellSelectionViewPositionSingle = 0,
	FKColoredCellSelectionViewPositionTop,
	FKColoredCellSelectionViewPositionBottom,
	FKColoredCellSelectionViewPositionMiddle
} FKColoredCellSelectionViewPosition;

/**
 This view can be used for UITableViewCell.selectedBackgroundView to draw a custom gradient in UITableViewCellStyleGrouped
 */
@interface FKColoredCellSelectionView : UIView

+ (id)coloredSelectionViewForTableViewCell:(UITableViewCell *)cell;

/** The position of the selectionView, either single, top, bottom oder middle */
@property (nonatomic, assign) FKColoredCellSelectionViewPosition position;
/** The start color for the gradient */
@property (nonatomic, strong) UIColor *gradientStartColor;
/** The end color for the gradient */
@property (nonatomic, strong) UIColor *gradientEndColor;

/** The line color */
@property (nonatomic, strong) UIColor *lineColor;
/** The width of the line around the view */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 Automatically determines the position of the cell with the given indexPath in the given tableView and sets it.
 
 @param tableView The tableView the cell is in
 @param indexPath The indexPath of the cell whose coloredCellSelectionView we want to update
 */
- (void)updatePositionForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
