// Part of iOSKit http://foundationk.it
//
// Derived from Lore Brichter's BSD-licensed ABTableViewCell: http://blog.atebits.com/2008/12/fast-scrolling-in-tweetie-with-uitableview/

#import <UIKit/UIKit.h>
#import "UITableViewCell+FKConcise.h"

/**
 This class is a base-class for a very fast, custom-drawn UITableViewCell.
 The cell automatically hides it's loading indicator when it gets reused.
 
 @see UITableViewCell+FKLoading
 @see UITableViewCell+FKConcise
 */

@interface FKTableViewCell : UITableViewCell {
    UIView *contentView_;
}

@property (nonatomic, strong, readonly) UIView *selectedContentView;

// subclasses must override
- (void)drawContentViewInRect:(CGRect)rect highlighted:(BOOL)highlighted;

@end
