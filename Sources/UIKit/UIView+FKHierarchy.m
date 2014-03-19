#import "UIView+FKHierarchy.h"

FKLoadCategory(UIViewFKHierarchy);

@implementation UIView (FKHierarchy)

- (UIViewController *)fkit_viewController {
    for (UIView* view = self; view != nil; view = view.superview) {
        UIResponder* nextResponder = view.nextResponder;
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    
    return nil;
}

- (id)fkit_superviewWithClass:(Class)aClass {
	return [self fkit_superviewWithClass:aClass strict:NO];
}

- (id)fkit_superviewWithClass:(Class)aClass strict:(BOOL)strict {
	UIView *view = self.superview;
    
	while (view != nil) {
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

- (id)fkit_descendantOrSelfWithClass:(Class)aClass {
    return [self fkit_descendantOrSelfWithClass:aClass strict:NO];
}

- (id)fkit_descendantOrSelfWithClass:(Class)aClass strict:(BOOL)strict {
    if (strict && [self isMemberOfClass:aClass]) {
        return self;
    } else if (!strict && [self isKindOfClass:aClass]) {
        return self;
    }
    
    for (UIView *child in self.subviews) {
        UIView *viewWithClass = [child fkit_descendantOrSelfWithClass:aClass strict:strict];
        
        if (viewWithClass != nil) {
            return viewWithClass;
        }
    }
    
    return nil;
}

- (void)fkit_removeAllSubviews {
    while (self.subviews.count > 0) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
