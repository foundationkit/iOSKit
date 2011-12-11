// Part of iOSKit http://foundationk.it


////////////////////////////////////////////////////////////////////////
#pragma mark - Detecting Interface Idiom
////////////////////////////////////////////////////////////////////////

NS_INLINE BOOL $isPad(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

NS_INLINE BOOL $isPhone(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
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

////////////////////////////////////////////////////////////////////////
#pragma mark - Managing device-specific resources for iPhone and iPad
////////////////////////////////////////////////////////////////////////

// returns the image name depending on the current device by appending "@iPad" when on iPad
NSString* FKDeviceSpecificImageName(NSString *imageName);
// you can specify your own appendix
NSString* FKDeviceSpecificImageNameWithAppendix(NSString *imageName, NSString *appendix);
// takes the current orientation on iPad into account by appending "@iPad-L" when in Landscape-Mode, otherwise "@iPad"
NSString* FKDeviceSpecificImageNameForOrientation(NSString *imageName, UIInterfaceOrientation orientation);
NSString* FKDeviceSpecificImageNameForOrientationWithAppendix(NSString *imageName, UIInterfaceOrientation orientation, NSString *appendix);
// Create Device-Specific Nib-Name
NSString* FKDeviceSpecificNibName(NSString *name);
