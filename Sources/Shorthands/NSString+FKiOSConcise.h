// Part of iOSKit http://foundationk.it
// 
// Derived from jverkoeys Nimbus-Project: http://github.com/jverkoey/nimbus

#import <Foundation/Foundation.h>

/**
 This category adds various additions to NSString in relation to UIKit for making life easier.
 */

@interface NSString (FKiOSConcise)

/**
 * Calculates the height of this text given the font, max width, and line break mode.
 * A convenience wrapper for sizeWithFont:constrainedToSize:lineBreakMode:
 */
- (CGFloat)heightWithFont: (UIFont*)font
       constrainedToWidth: (CGFloat)width
            lineBreakMode: (UILineBreakMode)lineBreakMode;

@end
