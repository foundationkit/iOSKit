#import "FKAudioRouteChange.h"


void FKAudioRouteChangeCallback(void *inUserData, AudioSessionPropertyID inPropertyID, UInt32 inPropertyValueSize, const void *inPropertyValue);
FKAudioRouteChangeReason FKAudioRouteChangeReasonFromReason(SInt32 reason);


static fk_audio_route_change_block routeChangeBlock;


void FKRegisterAudioRouteChangeBlock(fk_audio_route_change_block block) {
    // Only register listener the first time a change block is registered
    if (routeChangeBlock == nil) {
        // Registers the audio route change listener callback function
        AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, FKAudioRouteChangeCallback, (void *)NULL);
    }
    
    routeChangeBlock = [block copy];
}

void FKDeregisterAudioRouteChangeBlock(void) {
    routeChangeBlock = nil;
    AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_AudioRouteChange,FKAudioRouteChangeCallback, (void *)NULL);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Callback Function
////////////////////////////////////////////////////////////////////////

void FKAudioRouteChangeCallback(void *inUserData, AudioSessionPropertyID inPropertyID, UInt32 inPropertyValueSize, const void *inPropertyValue) {
    // ensure that this callback was invoked for a route change
    if (inPropertyID != kAudioSessionProperty_AudioRouteChange) { 
        return;
    }
    
    // Determines the reason for the route change
    CFDictionaryRef routeChangeDictionary = inPropertyValue;
    CFNumberRef routeChangeReasonRef = CFDictionaryGetValue(routeChangeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
    SInt32 routeChangeReason;
    
    CFNumberGetValue(routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
    
    // call block, if registered
    if (routeChangeBlock != nil) {
        routeChangeBlock(FKAudioRouteChangeReasonFromReason(routeChangeReason));
    }
}

FKAudioRouteChangeReason FKAudioRouteChangeReasonFromReason(SInt32 reason) {
    return (FKAudioRouteChangeReason)reason;
}
