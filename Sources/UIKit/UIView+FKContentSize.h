// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds functionality to UIView to be excluded from autocalculation of the 
 contentSize of an enclosing UIScrollView as well as automatically resizing a UIView to 
 its needed height while preserving its width.
 
 @see UIScrollView+FKContentSize
 */

@interface UIView (FKContentSize)

@property (nonatomic, assign, setter = fkit_setExcludedFromScrollViewAutocalculation:) BOOL fkit_excludedFromScrollViewAutocalculation;


/**
 Calls [self sizeToFitNeededHeightForWidth:self.frame.size.width]
 */
- (BOOL)fkit_sizeToFitNeededHeight;

/**
 This method acts differently, based on the type of view it gets executed. If there is no
 special handling for the type of the view executing, it just calls sizeToFit and returns NO
 to indicate that there was no special handling
 
 @return YES in case of a special size-action, NO otherwise
 */
- (BOOL)fkit_sizeToFitNeededHeightForWidth:(CGFloat)width;

@end
