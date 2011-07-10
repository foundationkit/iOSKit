// Part of FoundationKit http://foundationk.it


#if defined(TARGET_IPHONE_SIMULATOR) && (defined(DEBUG) || defined(CONFIGURATION_Debug))
#define NKSimulateMemoryWarning() CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#else
#define NKSimulateMemoryWarning()
#endif


NS_INLINE CGRect NKRectWithClearedOrigin(CGRect rect) {
    return CGRectMake(0,0,rect.size.width, rect.size.height);
}

NS_INLINE BOOL NKInterfaceOrientationsAreCounterpart(UIInterfaceOrientation interfaceOrientation1, UIInterfaceOrientation interfaceOrientation2) {
    return interfaceOrientation1 == UIInterfaceOrientationPortrait && interfaceOrientation2 == UIInterfaceOrientationPortraitUpsideDown ||
           interfaceOrientation1 == UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation2 == UIInterfaceOrientationPortrait ||
           interfaceOrientation1 == UIInterfaceOrientationLandscapeLeft && interfaceOrientation2 == UIInterfaceOrientationLandscapeRight ||
           interfaceOrientation1 == UIInterfaceOrientationLandscapeRight && interfaceOrientation2 == UIInterfaceOrientationLandscapeLeft;
}