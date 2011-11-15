// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds various shortcuts to UIBarButtonItem for making life easier.
 */
@interface UIBarButtonItem (FKConcise)

/**
 Creates a UIBarButtonItem with system style "Flexible Space".
 
 @return UIBarButtonItem with style UIBarButtonItemFlexibleSpace.
 */
+ (UIBarButtonItem *)flexibleSpaceItem;

/**
 Creates a UIBarButtonItem acting as a fixed-width spacer.
 
 @param width the width of the fixed-space item
 @return UIBarButtonItem with style UIBarButtonSystemItemFixedSpace
 */
+ (UIBarButtonItem *)spaceItemWithWidth:(CGFloat)width;

@end
