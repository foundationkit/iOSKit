// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface FKSoundEffect : NSObject

@property (nonatomic, readonly) SystemSoundID soundID;

+ (FKSoundEffect *)soundEffectWithContentsOfFile:(NSString *)path;

- (void)play;

@end
