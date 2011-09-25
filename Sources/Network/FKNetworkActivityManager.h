// Part of iOSKit http://foundationk.it
//
// Inspired by Ilya Kulakov's BSD-Licensed IKNetworkActivityManager

#import <Foundation/Foundation.h>

/**
 This class works as counting proxy for the networkActivityIndicator of UIApplication.
 You can add and remove network users, the networkActivityIndicator is shown as long
 as the number of network users is greater than zero.
 
 @see UIApplication+FKNetwork
 */

@interface FKNetworkActivityManager : NSObject

+ (void)addNetworkUser:(id)networkUser;
+ (void)removeNetworkUser:(id)networkUser;
+ (void)removeAllNetworkUsers;

@end
