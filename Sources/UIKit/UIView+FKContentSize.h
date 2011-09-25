// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds functionality to UIView to be excluded from autocalculation of the 
 contentSize of the enclosing UIScrollView.
 
 @see UIScrollView+FKContentSize
 */

@interface UIView (FKContentSize)

@property (nonatomic, assign) BOOL excludedFromScrollViewAutocalculation;

@end
