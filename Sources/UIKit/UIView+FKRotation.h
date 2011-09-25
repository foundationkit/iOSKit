// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds support for super-easy rotation of a UIView, when autoresizingMasks just
 don't work. You can specify a portraitFrame as well as a landscapeFrame and have methods to
 set the corresponding frame animated or directly (when already used in an animation-block like
 willAnimateToInterfaceOrientation.
 */

@interface UIView (FKRotation)

/** property to specify a frame for portrait orientation */
@property (nonatomic, assign) CGRect portraitFrame;
/** property to specify a frame for landscape orientation */
@property (nonatomic, assign) CGRect landscapeFrame;
/** specifies whether portrait and landscape frames are defined for this view */
@property (nonatomic, readonly) BOOL hasPortraitAndLandscapeFrames;


+ (id)viewWithPortraitFrame:(CGRect)portraitFrame landscapeFrame:(CGRect)landscapeFrame;

/**
 * Returns the frame set for the given interface orientation
 * 
 * @param interfaceOrientation the interface orientation that is used the determine the frame
 * @return the frame that is set for the given interface orientation
 */
- (CGRect)frameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

/**
 * Animates the frame to the frame for the given interface orientation
 *
 * @param toInterfaceOrientation the interface orientation that specifies the frame used
 * @param duration the duration of the animation
 */
- (void)animateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

/**
 * Sets the frame of the UIView to the frame for the current statusBarOrientation
 */
- (void)layoutView;

/**
 * Sets the frame of the UIView to the frame for the given interface orientation
 *
 * @param interfaceOrientation the interface orientation that specifies the frame used
 */
- (void)setFrameForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

/**
 * Sets the frames of all subviews that support rotation (hasPortraitAndLandscapeFrames == YES) (not recursive!) 
 * to the frame for the given interface orientation
 *
 * @param interfaceOrientation the interface orientation that specifies the frame used
 */
- (void)setSubviewFramesForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;

/**
 * Sets the frames of all subviews that support rotation (hasPortraitAndLandscapeFrames == YES)
 * to the frame for the given interface orientation, can work recursively over whole view-hierarchy
 *
 * @param interfaceOrientation the interface orientation that specifies the frame used
 * @param recursive flag that indicates if the method should be called recursively over whole view-hierarchy
 */
- (void)setSubviewFramesForInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation recursive:(BOOL)recursive;

@end
