// Part of iOSKit http://foundationk.it
//
// Derived from Oliver Drobnik's BSD-licensed DTCustomColoredAccessory: http://www.cocoanetics.com/2011/03/expandingcollapsing-tableview-sections/

#import <UIKit/UIKit.h>

typedef enum {
    FKColoredAccessoryViewTypeRight = 0,
    FKColoredAccessoryViewTypeLeft,
    FKColoredAccessoryViewTypeUp,
    FKColoredAccessoryViewTypeDown
} FKColoredAccessoryViewType;


/**
 This class serves as a simple way to color and/or rotate the standard UITableViewCellAccessoryStyleDefault - arrow.
 You can set it as an accessoryView on a UITableViewCell and specify the color and highlightedColor, as well as the
 orientation of the arrow (left, right, up, down).
 */
 
@interface FKColoredAccessoryView : UIControl

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, assign) FKColoredAccessoryViewType type;

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color;
+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color type:(FKColoredAccessoryViewType)type;

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;
+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor type:(FKColoredAccessoryViewType)type;
@end
