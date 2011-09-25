// Part of iOSKit http://foundationk.it
//
// Derived from Loren Brichter's BSD-licensed ABTableViewCell: http://blog.atebits.com/2008/12/fast-scrolling-in-tweetie-with-uitableview/

#import <UIKit/UIKit.h>

/**
 This class serves as the contentView of the fast, custom-drawn UITableViewCell.
 @see FKTableViewCell
 @see FKTableViewSelectedCellView
 */

@interface FKTableViewCellView : UIView

@end

/**
 This class serves as the contentView of the fast, custom-drawn UITableViewCell in the selected-state.
 @see FKTableViewCell
 @see FKTableViewCellView
 */

@interface FKTableViewSelectedCellView : UIView
@end