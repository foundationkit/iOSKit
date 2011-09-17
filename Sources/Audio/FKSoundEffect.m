#import "FKSoundEffect.h"
#import "FKShorthands.h"

@implementation FKSoundEffect

$synthesize(soundID);

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject
////////////////////////////////////////////////////////////////////////

-(void)dealloc {
    AudioServicesDisposeSystemSoundID(soundID_);
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark FKSoundEffect
////////////////////////////////////////////////////////////////////////

+ (FKSoundEffect *)soundEffectWithContentsOfFile:(NSString *)path {
    FKSoundEffect *soundEffect = nil;
    
    if (path) {
        NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        
        if (fileURL != nil) {
            SystemSoundID soundID;
            OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)fileURL, &soundID);
            
            if (error == kAudioServicesNoError) {
                soundEffect = [[FKSoundEffect alloc] init];
                soundEffect->soundID_ = soundID; 
            }
        } 
    }
    
    return soundEffect;
}

- (void)play {
    AudioServicesPlaySystemSound(self.soundID);
}


@end
