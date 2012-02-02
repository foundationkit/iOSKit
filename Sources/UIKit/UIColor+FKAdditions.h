// Part of iOSKit http://foundationk.it
//
// Derived From Erica Sadun's UIColor-Extensions: https://github.com/ars/uicolor-utilities/blob/master/UIColor-Expanded.h

#import <UIKit/UIKit.h>

/**
 This category add various additions to UIColor for making life easier.
 You get access to the RGB-components, as well as easy creation of UIColor-Objects
 based on Hex-Values or -Strings.
 */

@interface UIColor (FKAdditions)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat red;    // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green;  // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue;   // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white;  // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) UInt32 RGBHex;
/** Between 0.0 and 1.0 */
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) UIColor *inverseColor;


+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)randomColor;
+ (UIColor *)inverseColorToColor:(UIColor *)color;

- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

- (NSString *)stringRepresentation;
- (NSString *)hexStringRepresentation;

@end
