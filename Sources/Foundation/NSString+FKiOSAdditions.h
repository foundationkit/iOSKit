// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>

/**
 This category adds various additions to NSString related to UIKit or the iPhone
 */
@interface NSString (FKiOSAdditions)

/**
 This method removes all characters from NSString that are no valid phone number characters.
 
 @return a sanitized phone number
 */
- (NSString *)sanitizedPhoneNumber;

/**
 * Calculates the height of this text given the font, max width, and line break mode.
 * A convenience wrapper for sizeWithFont:constrainedToSize:lineBreakMode:
 */
- (CGFloat)heightWithFont:(UIFont *)font
       constrainedToWidth:(CGFloat)width
            lineBreakMode:(UILineBreakMode)lineBreakMode;

@end
