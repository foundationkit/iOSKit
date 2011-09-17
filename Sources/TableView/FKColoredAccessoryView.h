// Part of iOSKit http://foundationk.it
//
// Derived from Oliver Drobnik's BSD-licensed DTCustomColoredAccessory: http://www.cocoanetics.com/2011/03/expandingcollapsing-tableview-sections/

#import <UIKit/UIKit.h>

typedef enum {
    FKColoredAccessoryViewTypeRight = 0,
    FKColoredAccessoryViewTypeUp,
    FKColoredAccessoryViewTypeDown
} FKColoredAccessoryViewType;


@interface FKColoredAccessoryView : UIControl

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, assign) FKColoredAccessoryViewType type;

+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color;
+ (FKColoredAccessoryView *)accessoryViewWithColor:(UIColor *)color type:(FKColoredAccessoryViewType)type;

@end
