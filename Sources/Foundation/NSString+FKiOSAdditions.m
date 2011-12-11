#import "NSString+FKiOSAdditions.h"

@implementation NSString (FKiOSAdditions)

- (NSString *)sanitizedPhoneNumber {
    NSCharacterSet* validCharacters = [NSCharacterSet characterSetWithCharactersInString:@"1234567890-+"];
    NSString *phoneNumber = [self stringByReplacingOccurrencesOfString:@"(0)" withString:@""];
   
    return [[phoneNumber componentsSeparatedByCharactersInSet:[validCharacters invertedSet]] componentsJoinedByString:@""];
}

- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            lineBreakMode:(UILineBreakMode)lineBreakMode {
    return [self sizeWithFont:font
            constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                lineBreakMode:lineBreakMode].height;
}

@end
