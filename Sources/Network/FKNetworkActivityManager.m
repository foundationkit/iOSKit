#import "FKNetworkActivityManager.h"
#import "FKDispatch.h"

static NSMutableSet *networkUsers = nil;

FKDefineGCDQueueWithName(network_queue);

NS_INLINE void FKUpdateNetworkActivityIndicatorVisibility() {
    if (networkUsers.count > 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    } else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

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
    if (networkUser != nil) {
        dispatch_async(network_queue(), ^{
            [networkUsers addObject:networkUser];
            FKUpdateNetworkActivityIndicatorVisibility();
        });
    }
}

+ (void)removeNetworkUser:(id)networkUser {
    if (networkUser != nil) {
        dispatch_async(network_queue(), ^{
            [networkUsers removeObject:networkUser];
            FKUpdateNetworkActivityIndicatorVisibility();
        });
    }
}

+ (void)removeAllNetworkUsers {
    dispatch_async(network_queue(), ^{
        [networkUsers removeAllObjects];
        FKUpdateNetworkActivityIndicatorVisibility();
    });
}

@end
