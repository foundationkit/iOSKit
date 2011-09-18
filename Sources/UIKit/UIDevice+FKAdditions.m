#import "UIDevice+FKAdditions.h"
#include <sys/sysctl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (FKAdditions)

- (NSString *)ipAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

- (NSString *)debugInformation {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *appShortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]; 
    NSString *iphoneOSVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceType = [UIDevice currentDevice].hardwarePlatform;
    NSString *deviceUUID = [[UIDevice currentDevice] uniqueIdentifier];
    NSString *deviceLang = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    if ([UIDevice currentDevice].jailbroken) {
        deviceType = [NSString stringWithFormat:@"%@ (Possibly Jailbroken)", deviceType];
    }
    
    return [NSString stringWithFormat:@"%@ %@ %@\niOS: %@\nDevice: %@\nUUID: %@\nLang: %@", 
            appName, appVersion, (appShortVersion ? appShortVersion : @""), iphoneOSVersion, deviceType, deviceUUID, deviceLang];
}

- (NSString *)hardwarePlatform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return platform;
}

- (BOOL)isJailbroken {
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    NSFileManager *fileManger = [[NSFileManager alloc] init];
    
    if ([fileManger fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    
    if ([fileManger fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
}

- (BOOL)isSimulator {
	static NSString *simulatorModel = @"iPhone Simulator";
	return [[self model] isEqualToString:simulatorModel];	
}

- (void)simulateMemoryWarning {
#if (defined (DEBUG) || defined (CONFIGURATION_Debug))
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
}

@end
