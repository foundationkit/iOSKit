// Part of iOSKit http://foundationk.it
//
// Contains stuff from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

/**
 This category adds various additions to UIDevice for making life easier.
 Included are access to the IP Address, verbose debug information as well
 as checks for jailbroken devices or the simulator.
 */

@interface UIDevice (FKAdditions)

@property (nonatomic, readonly) NSString *ipAddress;
@property (nonatomic, readonly) NSString *debugInformation;
@property (nonatomic, readonly) NSString *hardwarePlatform;
@property (nonatomic, readonly, getter = isJailbroken) BOOL jailbroken;
@property (nonatomic, readonly) BOOL isSimulator;

- (void)simulateMemoryWarning;

@end
