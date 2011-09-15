// Part of iOSKit http://foundationk.it

#import "UIView+FKAnimations.h"

@implementation UIView (FKAnimations)

- (void)removeWithTransition:(UIViewAnimationTransition)transition duration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition:transition forView:self.superview cache:YES];
    
	[self removeFromSuperview];
    
	[UIView commitAnimations];
}

- (void)addSubview:(UIView *)view withTransition:(UIViewAnimationTransition)transition duration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition:transition forView:self cache:YES];
    
	[self addSubview:view];
    
	[UIView commitAnimations];
}

- (void)setFrame:(CGRect)frame duration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
    
	self.frame = frame;
    
	[UIView commitAnimations];
}

- (void)setAlpha:(float)alpha duration:(float)duration {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
    
	self.alpha = alpha;
    
	[UIView commitAnimations];
}

@end
