// Part of FoundationKit http://foundationk.it


#import "UIScreen+NKConcise.h"
#import "UIApplication+NKConcise.h"


NS_INLINE CGFloat NKScreenWidthForCurrentOrientation(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation) ? $screenWidth : $screenHeight;
}

NS_INLINE CGFloat NKScreenHeightForCurrentOrientation(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation) ? $screenHeight : $screenWidth;
}