#import "FKGroupedTableViewCell.h"

@implementation FKGroupedTableViewCell

$synthesize(selectionView);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        selectionView_ = [FKColoredCellSelectionView coloredSelectionViewForTableViewCell:self];
        
        if (self.selectionGradientStartColor != nil) {
            selectionView_.gradientStartColor = self.selectionGradientStartColor;
        }
        if (self.selectionGradientEndColor != nil) {
            selectionView_.gradientEndColor = self.selectionGradientEndColor;
        }
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self updatePosition];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewCell
////////////////////////////////////////////////////////////////////////

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self hideLoadingIndicator];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark FKGroupedTableViewCell
////////////////////////////////////////////////////////////////////////

// subclasses can override
- (UIColor *)selectionGradientStartColor {
    return nil;
}

// subclasses can override
- (UIColor *)selectionGradientEndColor {
    return nil;
}

- (void)updatePosition {
    UITableView *tableView = (UITableView *)self.superview;
    
    [self.selectionView updatePositionForTableView:tableView indexPath:[tableView indexPathForCell:self]];
}

@end
