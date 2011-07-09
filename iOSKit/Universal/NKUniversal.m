// Part of FoundationKit http://foundationk.it


#import "NKUniversal.h"

NS_INLINE BOOL NKIsIPad() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}


NS_INLINE BOOL NKIsIPhone() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}