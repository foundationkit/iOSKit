// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIScrollView (FKContentSize)

- (void)autocalculateContentHeight;
- (void)autocalculateContentHeightWithPadding:(CGFloat)padding;

- (void)autocalculateContentWidth;
- (void)autocalculateContentWidthWithPadding:(CGFloat)padding;

@end


@interface UIView (FKContentSize)

@property (nonatomic, unsafe_unretained) BOOL excludedFromScrollViewAutocalculation;

@end