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

/** The IP Address of the device, only works on WIFI */
@property (nonatomic, readonly) NSString *fkit_ipAddress;
/**
 A verbose description of the current device and application, useful for error reports
 Includes the App name, version, a check if it was pirated, the device type, UDID (as long
 as supported) etc.
 */
@property (nonatomic, readonly) NSString *fkit_debugInformation;
/** The current hardware platform of the device */
@property (nonatomic, readonly) NSString *fkit_hardwarePlatform;
/** Check for the simulator */
@property (nonatomic, readonly) BOOL fkit_isSimulator;
/** Check if Device has 4 inch Display */
@property (nonatomic, readonly) BOOL fkit_hasFourInchDisplay;

/**
 Simulates a memory warning on the device, if we are in debug-mode. 
 Does nothing otherwise.
 */
- (void)fkit_simulateMemoryWarning;

@end
