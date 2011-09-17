// Part of iOSKit http://foundationk.it
//
// Inspired by Ilya Kulakov's BSD-Licensed IKNetworkActivityManager

#import <Foundation/Foundation.h>

@interface FKNetworkActivityManager : NSObject

+ (void)addNetworkUser:(id)networkUser;
+ (void)removeNetworkUser:(id)networkUser;
+ (void)removeAllNetworkUsers;

@end
