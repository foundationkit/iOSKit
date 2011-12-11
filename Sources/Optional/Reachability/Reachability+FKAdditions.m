#import "Reachability+FKAdditions.h"
#import "FKSynthesizeSingleton.h"
#import "FKShorthands.h"
#import "NSNumber+FKConcise.h"
#import "NSDictionary+FKConcise.h"
#import "FKMath.h"

#define kFKReachabilityMinTimeBetweenNotifications  FKTimeIntervalSeconds(0.15)


@interface FKReachability ()

// re-define properties as read/write
@property (nonatomic, strong, readwrite) Reachability *reachability;
@property (nonatomic, assign, readwrite) NetworkStatus currentNetworkStatus;
@property (nonatomic, copy, readwrite) NSString *hostAddress;
// timestamp of last reachability change
@property (nonatomic, strong) NSDate *lastReachabilityChange;

- (void)reachabilityChanged:(NSNotification *)note;

@end

@implementation FKReachability

$synthesize(reachability);
$synthesize(currentNetworkStatus);
$synthesize(hostAddress);
$synthesize(lastReachabilityChange);

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

+ (FKReachability *)sharedReachability {
    FKDefineSingletonUsingBlock(^{
        return [[FKReachability alloc] init];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [reachability_ stopNotifier];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Reachability
////////////////////////////////////////////////////////////////////////

- (void)startCheckingHostAddress:(NSString *)hostAddress {
    self.hostAddress = hostAddress;
    
    // Listen for reachability changes
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityWithHostName:hostAddress];
    // we initially assume that we are reachable, a synchronous check of the 
    // current network status can take quite some time and can freeze the App 
    self.currentNetworkStatus = FKNetworkStatusReachableViaWWAN;
    self.lastReachabilityChange = [NSDate date];
    
    // start continous updates
    [self.reachability startNotifier];
    
    // we update real reachability status in the background to not block UI
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.currentNetworkStatus = (FKNetworkStatus)self.reachability.currentReachabilityStatus;
    });
}

- (void)setupReachabilityFor:(id)object {
    [self setupReachabilityFor:object sendInitialNotification:YES];
}

- (void)setupReachabilityFor:(id)object sendInitialNotification:(BOOL)sendInitialNotification {
    if ([object respondsToSelector:@selector(configureForNetworkStatus:)]) {
        // listen for FKReachability Notifications
        [[NSNotificationCenter defaultCenter] addObserver:object
                                                 selector:@selector(configureForNetworkStatus:)
                                                     name:kFKReachabilityChangedNotification
                                                   object:self.reachability];
        
        // perform initial setup
        if (sendInitialNotification) {
            NSNotification *notification = [NSNotification notificationWithName:kFKReachabilityChangedNotification 
                                                                         object:self.reachability
                                                                       userInfo:$dict($int(self.currentNetworkStatus),kFKNetworkStatusKey)];
            
            [object performSelector:@selector(configureForNetworkStatus:) withObject:notification];
        }
    }
}

- (void)shutdownReachabilityFor:(id)object {
    if ([object respondsToSelector:@selector(configureForNetworkStatus:)]) {
        [[NSNotificationCenter defaultCenter] removeObserver:object name:kFKReachabilityChangedNotification object:self];
    }
}

- (void)reachabilityChanged:(NSNotification *)note {
    FKNetworkStatus newNetworkStatus = FKReachabilityGetNetworkStatus(note);
    
    // if network status has changed, post notification
    if (newNetworkStatus != self.currentNetworkStatus) {
        self.currentNetworkStatus = newNetworkStatus;
        
        // we only send new notifications if a minimum amount of time is already bygone
		@synchronized(self.lastReachabilityChange) {
            if (ABS([self.lastReachabilityChange timeIntervalSinceNow]) > kFKReachabilityMinTimeBetweenNotifications) {
                self.lastReachabilityChange = [NSDate date];
                [[NSNotificationCenter defaultCenter] postNotificationName:kFKReachabilityChangedNotification
                                                                    object:self.reachability
                                                                  userInfo:$dict($int(newNetworkStatus),kFKNetworkStatusKey)];
            }
        }
    }
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark - Helper Functions
////////////////////////////////////////////////////////////////////////

FKNetworkStatus FKReachabilityGetNetworkStatus(NSNotification *note) {
    // get Reachability instance from notification
    Reachability* reachability = [note object];
    // get current status
    return (FKNetworkStatus)[reachability currentReachabilityStatus];
}
