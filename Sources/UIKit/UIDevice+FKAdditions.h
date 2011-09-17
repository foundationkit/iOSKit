// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIDevice (FKAdditions)

@property (nonatomic, readonly) NSString *ipAddress;
@property (nonatomic, readonly) NSString *debugInformation;
@property (nonatomic, readonly) NSString *hardwarePlatform;
@property (nonatomic, readonly, getter=isJailbroken) BOOL jailbroken;

- (void)simulateMemoryWarning;

@end
