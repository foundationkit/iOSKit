// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds functionality to UIScrollView to automatically determine
 the contentHeight or contentWidth based on it's subviews. It will use the
 greatest x- (for width) or y-value (for height) of any subview that is not marked
 to be excluded from autocalculation (and is not the scrolling indicator).
 
 @see UIView+FKContentSize
 */

@interface UIScrollView (FKContentSize)

- (void)autocalculateContentHeight;
- (void)autocalculateContentHeightWithPadding:(CGFloat)padding;

- (void)autocalculateContentWidth;
- (void)autocalculateContentWidthWithPadding:(CGFloat)padding;

- (void)autocalculateContentSize;
- (void)autocalculateContentSizeWithPadding:(CGSize)padding;

@end