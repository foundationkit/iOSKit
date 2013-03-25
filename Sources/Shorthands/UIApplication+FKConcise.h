// Part of iOSKit http://foundationk.it
//
// Derived from Peter Jihoon Kim's MIT-licensed ConciseKit: https://github.com/petejkim/ConciseKit


#define $app                [UIApplication sharedApplication]
#define $appDelegate        ((AppDelegate *)$app.delegate)
#define $appOrientation     $app.statusBarOrientation


NS_INLINE BOOL FKAppIsPortrait(void) {
    return UIInterfaceOrientationIsPortrait($appOrientation);
}

NS_INLINE BOOL FKAppIsLandscape(void) {
    return UIInterfaceOrientationIsLandscape($appOrientation);
}
