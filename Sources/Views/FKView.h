// Part of iOSKit http://foundationk.it
//
// Derived from @davidhemricks Blog-Post, seen on deallocated objects: 
// http://deallocatedobjects.com/posts/using-blocks-for-drawing?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+deallocatedobjects+%28Deallocated+Objects%29

#import <UIKit/UIKit.h>

/** Block typedef used for drawing the contents of the UIView */
typedef void (^fk_draw_block)(UIView *view, CGContextRef context);

/**
 This UIView subclass can be used for drawing content with a block.
 This goes together very well with FKDrawingUtilities for drawing a
 gradient view for example.
 */
@interface FKView : UIView

/** The block executed for drawing */
@property (nonatomic, copy) fk_draw_block drawingBlock;

/** Convenience method for creating a block-based drawing view.
 
 @param frame the frame of the view
 @param block the block used for drawing
 @return a view with the given frame and drawing block
 */
+ (id)viewWithFrame:(CGRect)frame drawingBlock:(fk_draw_block)block;

@end
