#import "FKColoredAccessoryView.h"

@implementation FKColoredAccessoryView

@synthesize color = color_;
@synthesize highlightedColor = highlightedColor_;
@synthesize type = type_;

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color {
	return [self accessoryViewWithColor:color highlightedColor:color type:FKColoredAccessoryViewTypeRight];
}

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color type:(FKColoredAccessoryViewType)type {
	return [self accessoryViewWithColor:color highlightedColor:color type:type];
}

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor {
    return [self accessoryViewWithColor:color highlightedColor:highlightedColor type:FKColoredAccessoryViewTypeRight];
}

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor type:(FKColoredAccessoryViewType)type {
    FKColoredAccessoryView *view = [[FKColoredAccessoryView alloc] initWithFrame:CGRectMake(0.f,0.f,15.f,15.f)];
	
    view.color = color;
    view.highlightedColor = highlightedColor;
    view.type = type;
    
	return view;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
        
        color_ = [UIColor blackColor];
        highlightedColor_ = [UIColor whiteColor];
        type_ = FKColoredAccessoryViewTypeRight;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (void)drawRect:(CGRect)rect {
    const CGFloat R = 4.5f;
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    
    switch (self.type) {
        case FKColoredAccessoryViewTypeRight: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-3.f;
            CGFloat y = CGRectGetMidY(self.bounds);
            
            CGContextMoveToPoint(ctxt, x-R, y-R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x-R, y+R);
            
            break;
        }
            
        case FKColoredAccessoryViewTypeLeft: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-3.f;
            CGFloat y = CGRectGetMidY(self.bounds);
            
            CGContextMoveToPoint(ctxt, x, y-R);
            CGContextAddLineToPoint(ctxt, x-R, y);
            CGContextAddLineToPoint(ctxt, x, y+R);
            
            break;
        }
            
        case FKColoredAccessoryViewTypeUp: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-7.f;
            CGFloat y = CGRectGetMinY(self.bounds)+5.f;
            
            CGContextMoveToPoint(ctxt, x-R, y+R);
            CGContextAddLineToPoint(ctxt, x, y);
            CGContextAddLineToPoint(ctxt, x+R, y+R);
            
            break;
        }
            
        case FKColoredAccessoryViewTypeDown: {
            // (x,y) is the tip of the arrow
            CGFloat x = CGRectGetMaxX(self.bounds)-7.f;
            CGFloat y = CGRectGetMaxY(self.bounds)-5.f;
            
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
    CGContextSetLineWidth(ctxt, 3.f);
    
	if (self.highlighted) {
		[self.highlightedColor setStroke];
	} else {
		[self.color setStroke];
	}
    
	CGContextStrokePath(ctxt);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIControl
////////////////////////////////////////////////////////////////////////

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

@end
