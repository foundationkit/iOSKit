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

@property (nonatomic, readonly) SystemSoundID soundID;
@property (nonatomic, fk_weak) id<FKSoundEffectDelegate> delegate;

+ (FKSoundEffect *)soundEffectWithContentsOfFile:(NSString *)path;

- (void)play;

@end


@protocol FKSoundEffectDelegate <NSObject>

@optional

- (void)soundEffectWillStartPlaying:(FKSoundEffect *)soundEffect;
- (void)soundEffectDidFinishPlaying:(FKSoundEffect *)soundEffect;

@end