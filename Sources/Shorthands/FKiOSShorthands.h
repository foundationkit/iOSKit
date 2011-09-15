// Part of iOSKit http://foundationk.it


#if TARGET_IPHONE_SIMULATOR && (defined(DEBUG) || defined(CONFIGURATION_Debug))
#define FKSimulateMemoryWarning() CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#else
#define FKSimulateMemoryWarning()
#endif


NS_INLINE CGRect FKRectWithClearedOrigin(CGRect rect) {
    return CGRectMake(0,0,rect.size.width, rect.size.height);
}

NS_INLINE BOOL FKInterfaceOrientationsAreCounterpart(UIInterfaceOrientation interfaceOrientation1, UIInterfaceOrientation interfaceOrientation2) {
    return interfaceOrientation1 == UIInterfaceOrientationPortrait && interfaceOrientation2 == UIInterfaceOrientationPortraitUpsideDown ||
           interfaceOrientation1 == UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation2 == UIInterfaceOrientationPortrait ||
           interfaceOrientation1 == UIInterfaceOrientationLandscapeLeft && interfaceOrientation2 == UIInterfaceOrientationLandscapeRight ||
           interfaceOrientation1 == UIInterfaceOrientationLandscapeRight && interfaceOrientation2 == UIInterfaceOrientationLandscapeLeft;
}