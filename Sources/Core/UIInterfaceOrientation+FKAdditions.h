// Part of iOSKit http://foundationk.it

#import "FKShorthands.h"
#import "FKUniversal.h"
#import "FKAssert.h"

/**
 Checks if two interface orientations are counterpart orientations.
 @return YES, if the orientations are counterpart, NO otherwise.
 */
NS_INLINE BOOL FKInterfaceOrientationsAreCounterpart(UIInterfaceOrientation interfaceOrientation1, UIInterfaceOrientation interfaceOrientation2) {
    return (interfaceOrientation1 == UIInterfaceOrientationPortrait && interfaceOrientation2 == UIInterfaceOrientationPortraitUpsideDown)  ||
    (interfaceOrientation1 == UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation2 == UIInterfaceOrientationPortrait)  ||
    (interfaceOrientation1 == UIInterfaceOrientationLandscapeLeft && interfaceOrientation2 == UIInterfaceOrientationLandscapeRight) ||
    (interfaceOrientation1 == UIInterfaceOrientationLandscapeRight && interfaceOrientation2 == UIInterfaceOrientationLandscapeLeft);
}

/**
 Returns a string representation of a interface orientation, useful for debugging.
 */
NS_INLINE NSString* FKInterfaceOrientationDescription(UIInterfaceOrientation interfaceOrientation) {
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return $stringify(UIInterfaceOrientationPortrait);
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return $stringify(UIInterfaceOrientationPortraitUpsideDown);
            
        case UIInterfaceOrientationLandscapeLeft:
            return $stringify(UIInterfaceOrientationLandscapeLeft);
            
        case UIInterfaceOrientationLandscapeRight:
            return $stringify(UIInterfaceOrientationLandscapeRight);
    }
    
    // should never happen
    FKAssert(NO, @"interfaceOrientation is not valid");
    
    return @"Unknown Orientation";
}

/**
 Common rotation: Rotate to all orientations on iPad, don't rotate on iPhone
 */
NS_INLINE BOOL FKRotateOnPad(UIInterfaceOrientation interfaceOrientation) {
    return $isPad() || interfaceOrientation == UIInterfaceOrientationPortrait;
}

/**
 Common rotation: Rotate to all orientations on iPad, don't rotate to PortraitUpsideDown on iPhone
 */
NS_INLINE BOOL FKRotateToAllSupportedOrientations(UIInterfaceOrientation interfaceOrientation) {
    return $isPad() || interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}