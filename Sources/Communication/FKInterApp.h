// Part of iOSKit http://foundationk.it
//
// Derived from Jeff Verkoeyen's Apache-Licensed Nimbus: http://jverkoey.github.com/nimbus

#import <Foundation/Foundation.h>

/**
 FKInterApp are a bunch of functions that can be used to communicate with
 other Apps on your iOS Device. You can open other Apps and check if given
 Apps are installed.
 */

#define kFKInterAppIDFacebook               @"284882215"
#define kFKInterAppIDTwitter                @"333903271"
#define kFKInterAppIDiBooks                 @"364709193"

#define kFKInterAppSchemeFacebook           @"fb://"
#define kFKInterAppSchemeTwitter            @"twitter://"
#define kFKInterAppSchemeiBooks             @"itms-books://"
#define kFKInterAppSchemePhone              @"tel://"
#define kFKInterAppSchemeMessages           @"sms://"
#define kFKInterAppSchemeChromeHTTP         @"googlechrome:"
#define kFKInterAppSchemeChromeHTTPS        @"googlechromes:"
#define kFKInterAppSchemeChromeXCallback    @"googlechrome-x-callback:"

/**
 Checks if the App with the given scheme is installed
 
 @param appScheme the scheme of the App, e.g. my-scheme://
 @return YES if the App is installed, NO otherwise
 */
BOOL FKInterAppApplicationIsInstalled(NSString *appScheme);

/**
 Checks if the phone App is installed
 
 @return YES if the phone App is installed, NO otherwise
 */
BOOL FKInterAppPhoneIsInstalled(void);

/**
 Opens the App with the given appScheme
 
 @param appScheme the scheme of the App, e.g. my-scheme://
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenApplication(NSString *appScheme);

/**
 Opens the App with the given appScheme and path
 
 @param appScheme the scheme of the App, e.g. my-scheme://
 @param appPath path that is supplied to the App
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenApplicationWithPath(NSString *appScheme, NSString *appPath);

/**
 Opens Safari with the given URL
 
 @param url the URL to display in Safari
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenSafari(NSURL *url);

/**
 Opens Phone with the given phoneNumber
 
 @param phoneNumber the number to display in Phone App
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenPhone(NSString *phoneNumber);

/**
 Opens Messages with the given phoneNumber
 
 @param phoneNumber the number to display in Messages App
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenMessages(NSString *phoneNumber);

/**
 Opens YouTube with the given video ID
 
 @param videoID the ID of the video to open in Youtube
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenYouTube(NSString *videoID);

/**
 Opens AppStore with the given App ID
 
 @param appID the ID of the App to display in AppStore
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenAppStore(NSString *appID);

/**
 Opens AppStore Review page with the given App ID
 
 @param appID the ID of the App to display in AppStore
 @return YES if the communication was successful, NO otherwise
 */
BOOL FKInterAppOpenAppStoreReview(NSString *appID);

BOOL FKInterAppChromeIsInstalled(void);
BOOL __attribute__((overloadable)) FKInterAppOpenChrome(NSURL *URL);
BOOL __attribute__((overloadable)) FKInterAppOpenChrome(NSURL *URL, NSURL *callbackURL, BOOL createNewTab);
