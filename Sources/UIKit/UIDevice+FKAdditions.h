// Part of iOSKit http://foundationk.it
//
// Contains stuff from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit

#import <UIKit/UIKit.h>

@interface UIDevice (FKAdditions)

@property (nonatomic, readonly) NSString *ipAddress;
@property (nonatomic, readonly) NSString *debugInformation;
@property (nonatomic, readonly) NSString *hardwarePlatform;
@property (nonatomic, readonly, getter = isJailbroken) BOOL jailbroken;
@property (nonatomic, readonly) BOOL isSimulator;

- (void)simulateMemoryWarning;

@end
