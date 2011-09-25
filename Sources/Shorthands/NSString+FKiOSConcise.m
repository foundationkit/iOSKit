#import "NSString+FKiOSConcise.h"

@implementation NSString (FKiOSConcise)

- (CGFloat)heightWithFont: (UIFont*)font
       constrainedToWidth: (CGFloat)width
            lineBreakMode: (UILineBreakMode)lineBreakMode {
    return [self sizeWithFont: font
            constrainedToSize: CGSizeMake(width, CGFLOAT_MAX)
                lineBreakMode: lineBreakMode].height;
}

@end
