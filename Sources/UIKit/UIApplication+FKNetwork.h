// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

/**
 This category adds support for the counting NetworkActivityIndicator-Proxy to UIApplication.
 @see FKNetworkActivityManager
 */

@interface UIApplication (FKNetwork)

- (void)addNetworkUser:(id)networkUser;
- (void)removeNetworkUser:(id)networkUser;
- (void)removeAllNetworkUsers;

@end
