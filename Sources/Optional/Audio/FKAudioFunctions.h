// Part of iOSKit http://foundationk.it

#import <AudioToolbox/AudioToolbox.h>

/**
 Vibrates the device. If the device doesn't support vibration, nothing happens.
 */
NS_INLINE void FKVibrateDevice() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}