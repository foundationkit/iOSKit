// Part of iOSKit http://foundationk.it


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Detecting Interface Idiom
////////////////////////////////////////////////////////////////////////

NS_INLINE BOOL $isPad(void);
NS_INLINE BOOL $isPhone(void);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Default-Rotation: Rotate to all orientations on iPad, don't rotate on iPhone
////////////////////////////////////////////////////////////////////////

NS_INLINE BOOL FKRotateOnPad(UIInterfaceOrientation interfaceOrientation);


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Managing device-specific rects/sizes/points for iPhone and iPad
////////////////////////////////////////////////////////////////////////

NS_INLINE CGRect FKRectMake(CGFloat xPhone, CGFloat yPhone, CGFloat widthPhone, CGFloat heightPhone, CGFloat xPad, CGFloat yPad, CGFloat widthPad, CGFloat heightPad);
NS_INLINE CGSize FKSizeMake(CGFloat widthPhone, CGFloat heightPhone, CGFloat widthPad, CGFloat heightPad);
NS_INLINE CGPoint FKPointMake(CGFloat xPhone, CGFloat yPhone, CGFloat xPad, CGFloat yPad);


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Managing device-specific resources for iPhone and iPad
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
