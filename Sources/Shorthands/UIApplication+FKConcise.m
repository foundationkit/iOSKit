#import "UIApplication+FKConcise.h"


NS_INLINE BOOL FKAppIsPortrait(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation);
}

NS_INLINE BOOL FKAppIsLandscape(void) {
    return UIInterfaceOrientationIsLandscape($appOrientation);
}