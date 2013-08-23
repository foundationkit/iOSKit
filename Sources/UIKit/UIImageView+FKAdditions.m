#import "UIImageView+FKAdditions.h"
#import <QuartzCore/QuartzCore.h>

FKLoadCategory(UIImageViewFKAdditions);

#define kFKFadeAnimationDuration    0.25

@implementation UIImageView (FKAdditions)

+ (UIImageView *)fkit_imageViewNamed:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

- (void)fkit_setImage:(UIImage *)image animated:(BOOL)animated {
    [self fkit_setImage:image duration:(animated ? kFKFadeAnimationDuration : 0.)];
}

- (void)fkit_setImage:(UIImage *)image duration:(NSTimeInterval)duration {
    if (duration > 0.) {
        CATransition *transition = [CATransition animation];
        
        transition.duration = duration;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.layer addAnimation:transition forKey:nil];
    }
    
    self.image = image;
}

@end
