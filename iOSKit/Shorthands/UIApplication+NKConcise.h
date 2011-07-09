// Part of FoundationKit http://foundationk.it
//
// Derived from Peter Jihoon Kim's MIT-licensed ConciseKit: https://github.com/petejkim/ConciseKit



#define $app                [UIApplication sharedApplication]
#define $delegate           $app.delegate
#define $appOrientation     $app.statusBarOrientation


NS_INLINE BOOL NKAppIsPortrait(void);
NS_INLINE BOOL NKAppIsLandscape(void);