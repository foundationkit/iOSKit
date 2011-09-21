// Part of iOSKit http://foundationk.it

#import <Foundation/Foundation.h>
#import "Reachability.h"

// we define our own notification to be more independent of Apple's Reachability
#define kFKReachabilityChangedNotification  @"kFKReachabilityChangedNotification"
#define kFKNetworkStatusKey                 @"kFKNetworkStatusKey"

// helper function to get reachability status out of Notification
NetworkStatus FKReachabilityGetNetworkStatus(NSNotification *note);


// Protocol for ViewController that are configured to use Reachability
@protocol FKReachabilityAware <NSObject>

@optional
- (void)configureForNetworkStatus:(NSNotification *)notification;

@end

@interface FKReachability : NSObject

@property (nonatomic, strong, readonly) Reachability *reachability;
@property (nonatomic, assign, readonly) NetworkStatus currentNetworkStatus;
@property (nonatomic, copy, readonly) NSString *hostAddress;

+ (FKReachability *)sharedReachability;

- (void)startCheckingHostAddress:(NSString *)hostAddress;

- (void)setupReachabilityFor:(id)object;
- (void)shutdownReachabilityFor:(id)object;

@end
