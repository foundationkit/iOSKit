#import "UICollectionReusableView+FKAdditions.h"

@implementation UICollectionReusableView (FKAdditions)

+ (NSString *)fkit_reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
