#import "FKTableViewCellView.h"
#import "FKTableViewCell.h"

@implementation FKTableViewCellView

- (id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:frame])) {
		self.contentMode = UIViewContentModeRedraw;
	}
    
	return self;
}

- (void)drawRect:(CGRect)rect {
	[(FKTableViewCell *)[self superview] drawContentViewInRect:rect highlighted:NO];
}

@end

@implementation FKTableViewSelectedCellView

- (id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:frame])) {
		self.contentMode = UIViewContentModeRedraw;
	}
    
	return self;
}

- (void)drawRect:(CGRect)rect {
	[(FKTableViewCell *)[self superview] drawContentViewInRect:rect highlighted:YES];
}

@end
