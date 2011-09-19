// Part of iOSKit http://foundationk.it


NS_INLINE BOOL FKInterfaceOrientationsAreCounterpart(UIInterfaceOrientation interfaceOrientation1, UIInterfaceOrientation interfaceOrientation2) {
    return (interfaceOrientation1 == UIInterfaceOrientationPortrait && interfaceOrientation2 == UIInterfaceOrientationPortraitUpsideDown)  ||
    (interfaceOrientation1 == UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation2 == UIInterfaceOrientationPortrait)  ||
    (interfaceOrientation1 == UIInterfaceOrientationLandscapeLeft && interfaceOrientation2 == UIInterfaceOrientationLandscapeRight) ||
    (interfaceOrientation1 == UIInterfaceOrientationLandscapeRight && interfaceOrientation2 == UIInterfaceOrientationLandscapeLeft);
}

NS_INLINE NSString* FKInterfaceOrientationDescription(UIInterfaceOrientation interfaceOrientation) {
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return @"Portrait";
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return @"Portrait Upside Down";
            
        case UIInterfaceOrientationLandscapeLeft:
            return @"Landscape Left";
            
        case UIInterfaceOrientationLandscapeRight:
            return @"Landscape Right";
    }
    
    // should never happen
    return @"Unknown orientation";
}


// Common rotation: Rotate to all orientations on iPad, don't rotate on iPhone
NS_INLINE BOOL FKRotateOnPad(UIInterfaceOrientation interfaceOrientation) {
    return $isPad() || interfaceOrientation == UIInterfaceOrientationPortrait;
}

// Common rotation: Rotate to all orientations on iPad, don't rotate to PortraitUpsideDown on iPhone
NS_INLINE BOOL FKRotateToAllSupportedOrientations(UIInterfaceOrientation interfaceOrientation) {
    return $isPad() || interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}