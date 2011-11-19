// Part of iOSKit http://foundationk.it
//
// Derived from Matt Gallagher's Blog-Post: http://cocoawithlove.com/2009/08/adding-shadow-effects-to-uitableview.html

#import <UIKit/UIKit.h>

/**
 This class adds shadows under the navigationBar, over the first row and under the
 last row of a UITableView to highlight the TableView
 */
@interface FKShadowedTableView : UITableView

/** The height of the shadows pointing downwards */
@property (nonatomic, assign) CGFloat shadowHeight;
/** The height of the shadows pointing upwards */
@property (nonatomic, assign) CGFloat inverseShadowHeight;

@end
