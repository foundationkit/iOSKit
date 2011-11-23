#import "UIButton+FKConcise.h"

@implementation UIButton (FKConcise)

+ (UIButton *)buttonWithImage:(UIImage *)image {
    UIButton *button = nil;
    
    if (image != nil) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = (CGRect){CGPointZero,image.size};
        [button setImage:image forState:UIControlStateNormal];
    }
    
    return button;
}

+ (UIButton *)buttonWithImageNamed:(NSString *)imageName {
    return [self buttonWithImage:[UIImage imageNamed:imageName]];
    
}

@end
