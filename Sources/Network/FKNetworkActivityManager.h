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

/**
 Adds a network user to the counting proxy. After this method is called with a networkUser != nil,
 the network activity indicator is shown.
 
 @param networkUser the network user to register
 */
+ (void)addNetworkUser:(id)networkUser;

/**
 Removes a network user from the counting proxy. If there are no network users left, the network 
 activity indicator gets hidden after this call.
 
 @param networkUser the network user to deregister
 */
+ (void)removeNetworkUser:(id)networkUser;

/**
 Removes all network users and hides the network activity indicator.
 */
+ (void)removeAllNetworkUsers;

@end
