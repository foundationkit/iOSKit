#import "UIApplication+FKNetwork.h"
#import "FKNetworkActivityManager.h"

@implementation UIApplication (FKNetwork)

- (void)addNetworkUser:(id)networkUser {
    [FKNetworkActivityManager addNetworkUser:networkUser];
}

- (void)removeNetworkUser:(id)networkUser {
    [FKNetworkActivityManager removeNetworkUser:networkUser];
}

- (void)removeAllNetworkUsers {
    [FKNetworkActivityManager removeAllNetworkUsers];
}

@end
