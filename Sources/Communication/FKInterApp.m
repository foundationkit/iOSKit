#import "FKInterApp.h"


BOOL FKInterAppApplicationIsInstalled(NSString *appScheme) {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]];
}

BOOL FKInterAppPhoneIsInstalled(void) {
    return FKInterAppApplicationIsInstalled(kFKInterAppSchemePhone);
}

BOOL FKInterAppOpenApplication(NSString *appScheme) {
    return FKInterAppOpenApplicationWithPath(appScheme, nil);
}

BOOL FKInterAppOpenApplicationWithPath(NSString *appScheme, NSString *appPath) {
    if (appScheme != nil) {
        NSString *urlPath = appScheme;
        
        if (appPath != nil) {
            urlPath = [urlPath stringByAppendingFormat:@"%@", appPath];
        }
        
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
    }
    
    return NO;
}

BOOL FKInterAppOpenSafari(NSURL *url) {
    return [[UIApplication sharedApplication] openURL:url];
}

BOOL FKInterAppOpenPhone(NSString *phoneNumber) {
    if (phoneNumber != nil) {
        NSString *appScheme = [kFKInterAppSchemePhone stringByAppendingString:[phoneNumber fkit_sanitizedPhoneNumber]];
      
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]];
    }
    
    return NO;
}

BOOL FKInterAppOpenMessages(NSString *phoneNumber) {
    if (phoneNumber != nil) {
        NSString *appScheme = [kFKInterAppSchemeMessages stringByAppendingString:[phoneNumber fkit_sanitizedPhoneNumber]];
        
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]];
    }
    
    return NO;
}

BOOL FKInterAppOpenYouTube(NSString *videoID) {
    NSString *urlPath = [@"http://www.youtube.com/watch?v=" stringByAppendingString:videoID];
   
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

BOOL FKInterAppOpenAppStore(NSString *appID) {
    NSString* urlPath = [@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=" stringByAppendingString:appID];
    
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

BOOL FKInterAppOpenAppStoreReview(NSString *appID) {
    NSString* urlPath = [@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" stringByAppendingString:appID];
    
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

BOOL FKInterAppChromeIsInstalled(void) {
    return FKInterAppApplicationIsInstalled(kFKInterAppSchemeChromeHTTP) || FKInterAppApplicationIsInstalled(kFKInterAppSchemeChromeHTTPS);
}

BOOL __attribute__((overloadable)) FKInterAppOpenChrome(NSURL *URL) {
    return FKInterAppOpenChrome(URL, nil, YES);
}

BOOL __attribute__((overloadable)) FKInterAppOpenChrome(NSURL *URL, NSURL *callbackURL, BOOL createNewTab) {
    NSURL *chromeSimpleURL = [NSURL URLWithString:kFKInterAppSchemeChromeHTTP];
    NSURL *chromeCallbackURL = [NSURL URLWithString:kFKInterAppSchemeChromeXCallback];

    if ([[UIApplication sharedApplication] canOpenURL:chromeCallbackURL]) {
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        NSString *scheme = [URL.scheme lowercaseString];

        if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
            NSMutableString *chromeURLString = [NSMutableString string];
            [chromeURLString appendFormat:@"%@//x-callback-url/open/?x-source=%@&url=%@",
             kFKInterAppSchemeChromeXCallback,
             [appName fkit_URLEncodedString],
             [[URL absoluteString] fkit_URLEncodedString]];

            if (callbackURL != nil) {
                [chromeURLString appendFormat:@"&x-success=%@", [[callbackURL absoluteString] fkit_URLEncodedString]];
            }

            if (createNewTab) {
                [chromeURLString appendString:@"&create-new-tab"];
            }

            NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
            return [[UIApplication sharedApplication] openURL:chromeURL];
        }
    } else if ([[UIApplication sharedApplication] canOpenURL:chromeSimpleURL]) {
        NSString *scheme = [URL.scheme lowercaseString];

        // Replace the URL Scheme with the Chrome equivalent.
        NSString *chromeScheme = nil;
        if ([scheme isEqualToString:@"http"]) {
            chromeScheme = kFKInterAppSchemeChromeHTTP;
        } else if ([scheme isEqualToString:@"https"]) {
            chromeScheme = kFKInterAppSchemeChromeHTTPS;
        }

        if (chromeScheme != nil) {
            NSString *absoluteString = [URL absoluteString];
            NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
            NSString *urlNoScheme = [absoluteString substringFromIndex:rangeForScheme.location + 1];
            NSString *chromeURLString = [chromeScheme stringByAppendingString:urlNoScheme];
            NSURL *chromeURL = [NSURL URLWithString:chromeURLString];

            return [[UIApplication sharedApplication] openURL:chromeURL];
        }
    }

    return NO;
}

