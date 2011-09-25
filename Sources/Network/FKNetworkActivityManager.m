#import "FKNetworkActivityManager.h"

static NSMutableSet *networkUsers = nil;
static dispatch_queue_t network_queue_;

dispatch_queue_t network_queue(void);

@implementation FKNetworkActivityManager

+ (void)initialize {
    if (self == [FKNetworkActivityManager class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            networkUsers = [NSMutableSet set];
        });
    }
}

+ (void)addNetworkUser:(id)networkUser {
    dispatch_sync_reentrant(network_queue(), ^{
        [networkUsers addObject:networkUser];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
}

+ (void)removeNetworkUser:(id)networkUser {
    dispatch_sync_reentrant(network_queue(), ^{
        [networkUsers removeObject:networkUser];
        
        if (networkUsers.count == 0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    });
}

+ (void)removeAllNetworkUsers {
    dispatch_sync_reentrant(network_queue(), ^{
        [networkUsers removeAllObjects];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helper Functions
////////////////////////////////////////////////////////////////////////

dispatch_queue_t network_queue(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network_queue_ = dispatch_queue_create("it.foundationk.FKNetworkActivityManager.network_queue", 0);
    });
    
    return network_queue_;
}
