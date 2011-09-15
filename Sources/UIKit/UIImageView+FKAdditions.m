#import "UIImageView+FKAdditions.h"
#import <QuartzCore/QuartzCore.h>


#define kFKFadeAnimation    0.25

@implementation UIImageView (FKAdditions)

+ (UIImageView *)imageViewNamed:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

- (void)setImage:(UIImage *)image animated:(BOOL)animated {
    if (animated) {
        CATransition *transition = [CATransition animation];
        
        transition.duration = kFKFadeAnimation;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        
        [self.layer addAnimation:transition forKey:nil];
    }
    
    self.image = image;
}

@end
