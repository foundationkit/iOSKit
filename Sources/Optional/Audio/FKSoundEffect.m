#import "FKSoundEffect.h"

void FKSystemSoundCompleted(SystemSoundID soundID, void *clientData);

@interface FKSoundEffect ()

- (void)fk_callDelegateWillStartPlaying;
- (void)fk_callDelegateDidStopPlaying;

@end

@implementation FKSoundEffect

@synthesize soundID = soundID_;
@synthesize delegate = delegate_;

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
                soundEffect->soundID_ = soundID; 
            }
        } 
    }
    
    return soundEffect;
}

-(void)dealloc {
    AudioServicesDisposeSystemSoundID(soundID_);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - FKSoundEffect
////////////////////////////////////////////////////////////////////////

- (void)play {
    [self fk_callDelegateWillStartPlaying];
    
    AudioServicesAddSystemSoundCompletion(self.soundID, CFRunLoopGetCurrent(), NULL, FKSystemSoundCompleted, (__bridge_retained void*)self);
    AudioServicesPlaySystemSound(self.soundID);
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Delegate Calls
////////////////////////////////////////////////////////////////////////

- (void)fk_callDelegateWillStartPlaying {
    if ([self.delegate respondsToSelector:@selector(soundEffectWillStartPlaying:)]) {
        [self.delegate soundEffectWillStartPlaying:self];
    }
}

- (void)fk_callDelegateDidStopPlaying {
    if ([self.delegate respondsToSelector:@selector(soundEffectDidFinishPlaying:)]) {
        [self.delegate soundEffectDidFinishPlaying:self];
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