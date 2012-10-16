#import "FKTableViewCell.h"
#import "FKTableViewCellView.h"
#import "UITableViewCell+FKLoading.h"


@implementation FKTableViewCell

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		contentView_ = [[FKTableViewCellView alloc] initWithFrame:CGRectZero];
		contentView_.opaque = YES;
		self.backgroundView = contentView_;
        
		_selectedContentView = [[FKTableViewSelectedCellView alloc] initWithFrame:CGRectZero];
		_selectedContentView.opaque = YES;
		self.selectedBackgroundView = _selectedContentView;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
    
	CGRect bounds = self.bounds;
	[contentView_ setFrame:bounds];
	[_selectedContentView setFrame:bounds];
}

- (void)setOpaque:(BOOL)opaque {
    [super setOpaque:opaque];
    
    self.contentView.opaque = opaque;
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[contentView_ setNeedsDisplay];
    
	if ([self isHighlighted] || [self isSelected]) {
		[_selectedContentView setNeedsDisplay];
	}
}

- (void)setNeedsDisplayInRect:(CGRect)rect {
	[super setNeedsDisplayInRect:rect];
	[contentView_ setNeedsDisplayInRect:rect];
    
	if([self isHighlighted] || [self isSelected]) {
		[_selectedContentView setNeedsDisplayInRect:rect];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
    // remove provided contentView
	self.contentView.hidden = YES;
	[self.contentView removeFromSuperview];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewCell
////////////////////////////////////////////////////////////////////////

- (void)setSelected:(BOOL)selected {
	[_selectedContentView setNeedsDisplay];
    
	if (!selected && self.selected) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setSelected:selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[_selectedContentView setNeedsDisplay];
    
	if (!selected && self.selected) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted {
	[_selectedContentView setNeedsDisplay];
    
	if (!highlighted && self.highlighted) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setHighlighted:highlighted];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[_selectedContentView setNeedsDisplay];
    
	if (!highlighted && self.highlighted) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setHighlighted:highlighted animated:animated];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self hideLoadingIndicator];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - FKTableViewCell
////////////////////////////////////////////////////////////////////////

- (void)drawContentViewInRect:(CGRect)rect highlighted:(BOOL)highlighted {
    [self doesNotRecognizeSelector:_cmd];
}

@end
