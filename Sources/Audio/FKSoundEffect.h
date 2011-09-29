// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import "FKiOSInternal.h"

@protocol FKSoundEffectDelegate;

/**
 This class is a simple Objective-C wrapper for playing a system sound.
 It supports optional delegate calls for playbackstart and -end.
 */
@interface FKSoundEffect : NSObject

/** The system sound ID of the soundEffect */
@property (nonatomic, readonly) SystemSoundID soundID;
/** The optional delegate that gets called when the soundEfeect starts/stops */
@property (nonatomic, fk_weak) id<FKSoundEffectDelegate> delegate;

/**
 Creates a SoundEffect out of a file

 @param path The path to the sound-file
 @return If successful, the SoundEffect encapsulating the SystemSound. Otherwise nil.
 */
+ (FKSoundEffect *)soundEffectWithContentsOfFile:(NSString *)path;

/**
 Starts playback of the SoundEffect. Calls the delegate.
 */
- (void)play;

@end

/**
 The optional delegate for the SoundEffect
 */
@protocol FKSoundEffectDelegate <NSObject>

@optional
/**
 Gets called immediately before the SoundEffect will start to play
 
 @param soundEffect The SoundEffect that will start to play
 */
- (void)soundEffectWillStartPlaying:(FKSoundEffect *)soundEffect;

/**
 Gets called after a SoundEffect finished playback
 
 @param soundEffect The SoundEffect that finished playback
 */
- (void)soundEffectDidFinishPlaying:(FKSoundEffect *)soundEffect;

@end