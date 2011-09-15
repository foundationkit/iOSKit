// Part of iOSKit http://foundationk.it
//
// Derived from Peter Jihoon Kim's MIT-licensed ConciseKit: https://github.com/petejkim/ConciseKit

#define $screen            [UIScreen mainScreen]
#define $screenBounds      $screen.bounds
#define $screenWidth       $screenBounds.size.width
#define $screenHeight      $screenBounds.size.height


NS_INLINE CGFloat FKScreenWidthForCurrentOrientation(void);
NS_INLINE CGFloat FKScreenHeightForCurrentOrientation(void);