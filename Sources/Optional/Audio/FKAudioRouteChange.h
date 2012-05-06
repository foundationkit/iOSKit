// Part of iOSKit http://foundationk.it

#import <AudioToolbox/AudioToolbox.h>

typedef enum {
    FKAudioRouteChangeReasonUnknown                     = kAudioSessionRouteChangeReason_Unknown,
    FKAudioRouteChangeReasonNewDeviceAvailable          = kAudioSessionRouteChangeReason_NewDeviceAvailable,
    FKAudioRouteChangeReasonOldDeviceUnavailable        = kAudioSessionRouteChangeReason_OldDeviceUnavailable,
    FKAudioRouteChangeReasonCategoryChange              = kAudioSessionRouteChangeReason_CategoryChange,
    FKAudioRouteChangeReasonOverride                    = kAudioSessionRouteChangeReason_Override,
    FKAudioRouteChangeReasonWakeFromSleep               = kAudioSessionRouteChangeReason_WakeFromSleep,
    FKAudioRouteChangeReasonNoSuitableRouteForCategory  = kAudioSessionRouteChangeReason_NoSuitableRouteForCategory
} FKAudioRouteChangeReason;


typedef void(^fk_audio_route_change_block)(FKAudioRouteChangeReason reason);

/**
 This function registers a callback block for responding to audio route changes (e.g. unplugging headsets).
 There can only be one callback block at a time, if you register a new one the old one gets overwritten.
 */
void FKRegisterAudioRouteChangeBlock(fk_audio_route_change_block block);

/** 
 This function deregisters a set callback block for responding to audio route changes and removes all
 references to the block to free up the memory used.
 */
void FKDeregisterAudioRouteChangeBlock(void);