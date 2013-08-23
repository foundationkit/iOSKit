#import "UIButton+FKConcise.h"

@implementation UIButton (FKConcise)

+ (UIButton *)fkit_buttonWithImage:(UIImage *)image {
    UIButton *button = nil;
    
    if (image != nil) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = (CGRect){CGPointZero,image.size};
        [button setImage:image forState:UIControlStateNormal];
    }
    
    return button;
}

+ (UIButton *)fkit_buttonWithImageNamed:(NSString *)imageName {
    return [self fkit_buttonWithImage:[UIImage imageNamed:imageName]];
    
}

@end
