#import "UIView+FKHierarchy.h"

FKLoadCategory(UIViewFKHierarchy);

@implementation UIView (FKHierarchy)

- (UIViewController *)viewController {
    for (UIView* view = self; view != nil; view = view.superview) {
        UIResponder* nextResponder = view.nextResponder;
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

- (NSInteger)subviewIndex {
	return (NSInteger)[self.superview.subviews indexOfObject:self];
}

- (UIView *)superviewWithClass:(Class)aClass {
	return [self superviewWithClass:aClass strict:NO];
}

- (UIView *)superviewWithClass:(Class)aClass strict:(BOOL)strict {
	UIView *view = self.superview;
    
	while(view) {
		if(strict && [view isMemberOfClass:aClass]) {
			break;
		} else if(!strict && [view isKindOfClass:aClass]) {
			break;
		} else {
			view = view.superview;
		}
	}
    
	return view;
}

- (UIView*)descendantOrSelfWithClass:(Class)aClass {
    return [self descendantOrSelfWithClass:aClass strict:NO];
}

- (UIView *)descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict {
    if (strict && [self isMemberOfClass:aClass]) {
        return self;
    } else if (!strict && [self isKindOfClass:aClass]) {
        return self;
    }
    
    for (UIView* child in self.subviews) {
        UIView* viewWithClass = [child descendantOrSelfWithClass:aClass strict:strict];
        
        if (viewWithClass != nil) {
            return viewWithClass;
        }
    }
    
    return nil;
}

- (void)removeAllSubviews {
    while (self.subviews.count > 0) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)bringToFront {
	[self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
	[self.superview sendSubviewToBack:self];
}

- (void)bringOneLevelUp {
	NSInteger currentIndex = self.subviewIndex;
	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

- (void)sendOneLevelDown {
	NSInteger currentIndex = self.subviewIndex;
	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

- (BOOL)isInFront {
	return (self.superview.subviews.lastObject == self);
}

- (BOOL)isAtBack {
	return ([self.superview.subviews objectAtIndex:0] == self);
}

- (void)swapDepthsWithView:(UIView *)swapView {
	[self.superview exchangeSubviewAtIndex:self.subviewIndex withSubviewAtIndex:swapView.subviewIndex];
}


@end
