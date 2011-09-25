#import "FKTableViewCell.h"
#import "FKTableViewCellView.h"
#import "FKShorthands.h"


@implementation FKTableViewCell

$synthesize(contentView);
$synthesize(selectedContentView);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		contentView_ = [[FKTableViewCellView alloc] initWithFrame:CGRectZero];
		contentView_.opaque = YES;
		self.backgroundView = contentView_;
        
		selectedContentView_ = [[FKTableViewSelectedCellView alloc] initWithFrame:CGRectZero];
		selectedContentView_.opaque = YES;
		self.selectedBackgroundView = selectedContentView_;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewCell
////////////////////////////////////////////////////////////////////////

- (void)setSelected:(BOOL)selected {
	[selectedContentView_ setNeedsDisplay];
    
	if (!selected && self.selected) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setSelected:selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[selectedContentView_ setNeedsDisplay];
    
	if (!selected && self.selected) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted {
	[selectedContentView_ setNeedsDisplay];
    
	if (!highlighted && self.highlighted) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setHighlighted:highlighted];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[selectedContentView_ setNeedsDisplay];
    
	if (!highlighted && self.highlighted) {
		[contentView_ setNeedsDisplay];
	}
    
	[super setHighlighted:highlighted animated:animated];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (void)setFrame:(CGRect)f {
	[super setFrame:f];
    
	CGRect bounds = [self bounds];
	[contentView_ setFrame:bounds];
	[selectedContentView_ setFrame:bounds];
}

- (void)setOpaque:(BOOL)opaque {
    [super setOpaque:opaque];
    
    self.contentView.opaque = opaque;
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[contentView_ setNeedsDisplay];
    
	if ([self isHighlighted] || [self isSelected]) {
		[selectedContentView_ setNeedsDisplay];
	}
}

- (void)setNeedsDisplayInRect:(CGRect)rect {
	[super setNeedsDisplayInRect:rect];
	[contentView_ setNeedsDisplayInRect:rect];
    
	if([self isHighlighted] || [self isSelected]) {
		[selectedContentView_ setNeedsDisplayInRect:rect];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
    // remove provided contentView
	self.contentView.hidden = YES;
	[self.contentView removeFromSuperview];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark FKTableViewCell
////////////////////////////////////////////////////////////////////////

- (void)drawContentViewInRect:(CGRect)rect highlighted:(BOOL)highlighted {
    [self doesNotRecognizeSelector:_cmd];
}

@end
