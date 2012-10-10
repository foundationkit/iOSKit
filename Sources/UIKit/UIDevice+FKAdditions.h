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
@property (nonatomic, readonly) NSString *ipAddress;
/**
 A verbose description of the current device and application, useful for error reports
 Includes the App name, version, a check if it was pirated, the device type, UDID (as long
 as supported) etc.
 */
@property (nonatomic, readonly) NSString *debugInformation;
/** The current hardware platform of the device */
@property (nonatomic, readonly) NSString *hardwarePlatform;
/** A non-bulletproof check for jailbroken devices */
@property (nonatomic, readonly, getter = isJailbroken) BOOL jailbroken;
/** Check for crappy (slow) devices, currently includes iPhones up to 3GS and the iPad 1 */
@property (nonatomic, readonly) BOOL isCrappy;
/** Check for the simulator */
@property (nonatomic, readonly) BOOL isSimulator;
/** Check if Device has 4 inch Display */
@property (nonatomic, readonly) BOOL hasFourInchDisplay;

/**
 Simulates a memory warning on the device, if we are in debug-mode. 
 Does nothing otherwise.
 */
- (void)simulateMemoryWarning;

@end
