// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@protocol FKSoundEffectDelegate;

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