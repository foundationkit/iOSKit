#import "UIView+FKAnimations.h"

FKLoadCategory(UIViewFKAnimations);

#define kFKFadeDuration     0.25

@implementation UIView (FKAnimations)

- (void)fkit_setFrame:(CGRect)frame duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.frame = frame;
                     } completion:nil];
}

- (void)fkit_setAlpha:(CGFloat)alpha duration:(NSTimeInterval)duration {
    if (ABS(self.alpha - alpha) > 0.00001f) {
        [UIView animateWithDuration:duration
                              delay:0.
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.alpha = alpha;
                         } completion:nil];
    }
}

- (void)fkit_fadeIn {
    [self fkit_setAlpha:1.f duration:kFKFadeDuration];
}

- (void)fkit_fadeOut {
	[self fkit_setAlpha:0.f duration:kFKFadeDuration];
}

- (void)fkit_fadeOutAndRemoveFromSuperview {
	[UIView animateWithDuration:kFKFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         self.alpha = 1.f;
                     }];
}

@end
