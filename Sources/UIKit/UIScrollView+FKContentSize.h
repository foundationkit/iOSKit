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

- (void)fkit_autocalculateContentHeight;
- (void)fkit_autocalculateContentHeightWithPadding:(CGFloat)padding;

- (void)fkit_autocalculateContentWidth;
- (void)fkit_autocalculateContentWidthWithPadding:(CGFloat)padding;

- (void)fkit_autocalculateContentSize;
- (void)fkit_autocalculateContentSizeWithPadding:(CGSize)padding;

@end


BOOL FKViewIsScrollIndicator(UIView *view);
