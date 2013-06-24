#import "NSString+FKiOSAdditions.h"

@implementation NSString (FKiOSAdditions)

- (NSString *)sanitizedPhoneNumber {
    NSCharacterSet *validCharacters = [NSCharacterSet characterSetWithCharactersInString:@"1234567890-+"];
    NSString *phoneNumber = [self stringByReplacingOccurrencesOfString:@"(0)" withString:@""];
   
    return [[phoneNumber componentsSeparatedByCharactersInSet:[validCharacters invertedSet]] componentsJoinedByString:@""];
}

@end
