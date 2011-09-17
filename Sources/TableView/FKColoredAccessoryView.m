#import "FKColoredAccessoryView.h"
#import "FKShorthands.h"

@implementation FKColoredAccessoryView

$synthesize(color);
$synthesize(highlightedColor);
$synthesize(type);

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color {
	return [self accessoryViewWithColor:color type:FKColoredAccessoryViewTypeRight];
}

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color type:(FKColoredAccessoryViewType)type {
	FKColoredAccessoryView *view = [[FKColoredAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 15.0, 15.0)];
	
    view.color = color;
    view.type = type;
    
	return view;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
        
        color_ = [UIColor blackColor];
        highlightedColor_ = [UIColor whiteColor];
        type_ = FKColoredAccessoryViewTypeRight;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    const CGFloat R = 4.5;
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    
    switch (self.type) {
        case FKColoredAccessoryViewTypeRight: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-3.0;;
            CGFloat y = CGRectGetMidY(self.bounds);
            
            CGContextMoveToPoint(ctxt, x-R, y-R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x-R, y+R);
            
            break;
        }
            
        case FKColoredAccessoryViewTypeUp: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-7.0;;
            CGFloat y = CGRectGetMinY(self.bounds)+5.0;
            
            CGContextMoveToPoint(ctxt, x-R, y+R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x+R, y+R);
            
            break;
        }
            
        case FKColoredAccessoryViewTypeDown: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-7.0;;
            CGFloat y = CGRectGetMaxY(self.bounds)-5.0;
            
            CGContextMoveToPoint(ctxt, x-R, y-R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x+R, y-R);
            
            break;
        }
            
        default:
            break;
    }
    
    CGContextSetLineCap(ctxt, kCGLineCapSquare);
    CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
    CGContextSetLineWidth(ctxt, 3);
    
	if (self.highlighted) {
		[self.highlightedColor setStroke];
	} else {
		[self.color setStroke];
	}
    
	CGContextStrokePath(ctxt);
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIControl
////////////////////////////////////////////////////////////////////////

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

@end
