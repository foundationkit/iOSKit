// Part of iOSKit http://foundationk.it

#import <UIKit/UIKit.h>

@interface UIApplication (FKNetwork)

- (void)addNetworkUser:(id)networkUser;
- (void)removeNetworkUser:(id)networkUser;
- (void)removeAllNetworkUsers;

@end
