#import "FKGroupedTableViewCell.h"

@implementation FKGroupedTableViewCell

@synthesize selectionView = selectionView_;

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
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
#pragma mark - UITableViewCell
////////////////////////////////////////////////////////////////////////

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self hideLoadingIndicator];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [self updateSelectionViewPosition];
    
    [super setHighlighted:highlighted animated:animated];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - FKGroupedTableViewCell
////////////////////////////////////////////////////////////////////////

// subclasses can override
- (UIColor *)selectionGradientStartColor {
    return nil;
}

// subclasses can override
- (UIColor *)selectionGradientEndColor {
    return nil;
}

- (void)updateSelectionViewPosition {
    UITableView *tableView = (UITableView *)self.superview;
    
    [self.selectionView updatePositionForTableView:tableView indexPath:[tableView indexPathForCell:self]];
}

@end
