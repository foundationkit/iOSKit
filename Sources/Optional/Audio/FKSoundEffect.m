#import "FKSoundEffect.h"

void FKSystemSoundCompleted(SystemSoundID soundID, void *clientData);

@interface FKSoundEffect ()

- (void)fk_callDelegateWillStartPlaying;
- (void)fk_callDelegateDidStopPlaying;

@end

@implementation FKSoundEffect {
    BOOL _soundIDCreated;
}

////////////////////////////////////////////////////////////////////////
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

+ (FKSoundEffect *)soundEffectWithContentsOfFile:(NSString *)path {
    FKSoundEffect *soundEffect = nil;
    
    if (path) {
        NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        
        if (fileURL != nil) {
            SystemSoundID soundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &soundID);
            
            if (error == kAudioServicesNoError) {
                soundEffect = [[FKSoundEffect alloc] init];
                soundEffect->_soundID = soundID;
                soundEffect->_soundIDCreated = YES;
            }
        } 
    }
    
    return soundEffect;
}

+ (FKSoundEffect *)soundEffectWithSoundID:(SystemSoundID)soundID {
    FKSoundEffect *soundEffect = [[FKSoundEffect alloc] init];
    soundEffect->_soundID = soundID;

    return soundEffect;
}

-(void)dealloc {
    if (_soundIDCreated) {
        AudioServicesDisposeSystemSoundID(_soundID);
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - FKSoundEffect
////////////////////////////////////////////////////////////////////////

- (void)play {
    [self fk_callDelegateWillStartPlaying];
    
    AudioServicesAddSystemSoundCompletion(self.soundID, CFRunLoopGetCurrent(), NULL, self.delegate != nil ? FKSystemSoundCompleted : NULL, (__bridge_retained void*)self);
    AudioServicesPlaySystemSound(self.soundID);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Delegate Calls
////////////////////////////////////////////////////////////////////////

- (void)fk_callDelegateWillStartPlaying {
    id<FKSoundEffectDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(soundEffectWillStartPlaying:)]) {
        [delegate soundEffectWillStartPlaying:self];
    }
}

- (void)fk_callDelegateDidStopPlaying {
    id<FKSoundEffectDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(soundEffectDidFinishPlaying:)]) {
        [delegate soundEffectDidFinishPlaying:self];
    }
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark - Helper Functions
////////////////////////////////////////////////////////////////////////

void FKSystemSoundCompleted(SystemSoundID soundID, void *clientData) {
    if (clientData) {
        FKSoundEffect *soundEffect = (__bridge_transfer FKSoundEffect*)clientData;
        [soundEffect fk_callDelegateDidStopPlaying];
    }
}
