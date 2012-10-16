#import "FKShadowedTableView.h"
#import "NSArray+FKConcise.h"
#import "FKShorthands.h"
#import <QuartzCore/QuartzCore.h>

#define kFKDefaultShadowHeight          20.f
#define kFKDefaultInverseShadowHeight   10.f

@interface FKShadowedTableView () {
    CAGradientLayer *originShadow;
	CAGradientLayer *topShadow;
	CAGradientLayer *bottomShadow;
}

@property (nonatomic, readonly) CGFloat fk_shadowRatio;

- (CAGradientLayer *)fk_shadowLayerInversed:(BOOL)inverse;

@end

@implementation FKShadowedTableView

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if ((self = [super initWithFrame:frame style:style])) {
        _shadowHeight = kFKDefaultShadowHeight;
        _inverseShadowHeight = kFKDefaultInverseShadowHeight;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// Construct the origin shadow if needed
	if (!originShadow) {
		originShadow = [self fk_shadowLayerInversed:NO];
		[self.layer insertSublayer:originShadow atIndex:0];
	} else if (![[self.layer.sublayers objectAtIndex:0] isEqual:originShadow]) {
		[self.layer insertSublayer:originShadow atIndex:0];
	}
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
	// Stretch and place the origin shadow
	CGRect originShadowFrame = originShadow.frame;
	originShadowFrame.size.width = self.frame.size.width;
	originShadowFrame.origin.y = self.contentOffset.y;
	originShadow.frame = originShadowFrame;
	
	[CATransaction commit];
	
	NSArray *indexPathsForVisibleRows = [self indexPathsForVisibleRows];
	
    if ([indexPathsForVisibleRows count] == 0) {
		[topShadow removeFromSuperlayer];
		topShadow = nil;
		[bottomShadow removeFromSuperlayer];
		bottomShadow = nil;
		return;
	}
	
	NSIndexPath *firstRow = [indexPathsForVisibleRows objectAtIndex:0];
	
    if ([firstRow section] == 0 && [firstRow row] == 0) {
		UIView *cell = [self cellForRowAtIndexPath:firstRow];
		
        if (!topShadow) {
			topShadow = [self fk_shadowLayerInversed:YES];
			[cell.layer insertSublayer:topShadow atIndex:0];
		} else if ([cell.layer.sublayers indexOfObjectIdenticalTo:topShadow] != 0) {
			[cell.layer insertSublayer:topShadow atIndex:0];
		}
        
		CGRect shadowFrame = topShadow.frame;
		shadowFrame.size.width = cell.frame.size.width;
		shadowFrame.origin.y = -self.inverseShadowHeight;
		topShadow.frame = shadowFrame;
	}
	
    else {
		[topShadow removeFromSuperlayer];
		topShadow = nil;
	}
    
	NSIndexPath *lastRow = [indexPathsForVisibleRows lastObject];
	
    if ([lastRow section] == [self numberOfSections] - 1 &&
		[lastRow row] == [self numberOfRowsInSection:[lastRow section]] - 1) {
		UIView *cell = [self cellForRowAtIndexPath:lastRow];
        
		if (!bottomShadow) {
			bottomShadow = [self fk_shadowLayerInversed:NO];
			[cell.layer insertSublayer:bottomShadow atIndex:0];
		} else if ([cell.layer.sublayers indexOfObjectIdenticalTo:bottomShadow] != 0) {
			[cell.layer insertSublayer:bottomShadow atIndex:0];
		}
        
		CGRect shadowFrame = bottomShadow.frame;
		shadowFrame.size.width = cell.frame.size.width;
		shadowFrame.origin.y = cell.frame.size.height;
		bottomShadow.frame = shadowFrame;
	} else {
		[bottomShadow removeFromSuperlayer];
		bottomShadow = nil;
	}
}

////////////////////////////////////////////////////////////////////////
#pragma mark - FKShadowedTableView
////////////////////////////////////////////////////////////////////////

- (CGFloat)fk_shadowRatio {
    return self.inverseShadowHeight / self.shadowHeight;
}


- (CAGradientLayer *)fk_shadowLayerInversed:(BOOL)inverse {
	CAGradientLayer *shadowLayer = [[CAGradientLayer alloc] init];
	CGRect frame = CGRectMake(0, 0, self.frame.size.width, inverse ? self.inverseShadowHeight : self.shadowHeight);
    UIColor *darkColor =  [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:inverse ? self.fk_shadowRatio * 0.5f : 0.5f];
	UIColor *lightColor = [self.backgroundColor colorWithAlphaComponent:0.0];
    
	shadowLayer.frame = frame;
    
    if (inverse) {
        shadowLayer.colors = @[(id)[lightColor CGColor], (id)[darkColor CGColor]];
    } else {
        shadowLayer.colors = @[(id)[darkColor CGColor], (id)[lightColor CGColor]];
    }
    
	return shadowLayer;
}

@end
