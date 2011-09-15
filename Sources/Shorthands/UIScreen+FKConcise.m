// Part of iOSKit http://foundationk.it


#import "UIScreen+FKConcise.h"
#import "UIApplication+FKConcise.h"


NS_INLINE CGFloat FKScreenWidthForCurrentOrientation(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation) ? $screenWidth : $screenHeight;
}

NS_INLINE CGFloat FKScreenHeightForCurrentOrientation(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation) ? $screenHeight : $screenWidth;
}