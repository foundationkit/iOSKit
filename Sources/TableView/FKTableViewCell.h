// Part of iOSKit http://foundationk.it
//
// Derived from Lore Brichter's BSD-licensed ABTableViewCell: http://blog.atebits.com/2008/12/fast-scrolling-in-tweetie-with-uitableview/

#import <UIKit/UIKit.h>
#import "UITableViewCell+FKConcise.h"

@interface FKTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIView *selectedContentView;

// subclasses must override
- (void)drawContentViewInRect:(CGRect)rect highlighted:(BOOL)highlighted;

@end
