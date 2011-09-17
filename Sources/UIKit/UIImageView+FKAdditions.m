#import "UIImageView+FKAdditions.h"
#import <QuartzCore/QuartzCore.h>


#define kFKFadeAnimation    0.25

@implementation UIImageView (FKAdditions)

+ (UIImageView *)imageViewNamed:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

- (void)setImage:(UIImage *)image animated:(BOOL)animated {
    [self setImage:image duration:(animated ? kFKFadeAnimation : 0.)];
}

- (void)setImage:(UIImage *)image duration:(NSTimeInterval)duration {
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
