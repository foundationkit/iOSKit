// Part of iOSKit http://foundationk.it

#import "UIDevice+FKAdditions.h"


////////////////////////////////////////////////////////////////////////
#pragma mark - Detecting Interface Idiom
////////////////////////////////////////////////////////////////////////

NS_INLINE BOOL $isPad(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

NS_INLINE BOOL $isPhone(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

NS_INLINE BOOL $isPhone5(void) {
    return [[UIDevice currentDevice] fkit_hasFourInchDisplay];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Managing device-specific rects/sizes/points for iPhone and iPad
////////////////////////////////////////////////////////////////////////

NS_INLINE CGRect FKRectMake(CGFloat xPhone, CGFloat yPhone, CGFloat widthPhone, CGFloat heightPhone, CGFloat xPad, CGFloat yPad, CGFloat widthPad, CGFloat heightPad) {
    return $isPad() ? CGRectMake(xPad, yPad, widthPad, heightPad) : CGRectMake(xPhone, yPhone, widthPhone, heightPhone);
}

NS_INLINE CGSize FKSizeMake(CGFloat widthPhone, CGFloat heightPhone, CGFloat widthPad, CGFloat heightPad) {
    return $isPad() ? CGSizeMake(widthPad, heightPad) : CGSizeMake(widthPhone, heightPhone);
}

NS_INLINE CGPoint FKPointMake(CGFloat xPhone, CGFloat yPhone, CGFloat xPad, CGFloat yPad) {
    return $isPad() ? CGPointMake(xPad, yPad) : CGPointMake(xPhone, yPhone);
}
