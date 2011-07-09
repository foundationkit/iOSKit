// Part of FoundationKit http://foundationk.it


#import "UIApplication+NKConcise.h"


NS_INLINE BOOL NKAppIsPortrait(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation);
}

NS_INLINE BOOL NKAppIsLandscape(void) {
    return UIInterfaceOrientationIsLandscape($appOrientation);
}