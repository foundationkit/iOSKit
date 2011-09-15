#import "UIImageView+FKAdditions.h"

@implementation UIImageView (FKAdditions)

+ (UIImageView *)imageViewNamed:(NSString *)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

@end
