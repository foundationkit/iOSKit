#import "FKInterApp.h"
#import "NSString+FKiOSAdditions.h"


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
        NSString *appScheme = [kFKInterAppSchemePhone stringByAppendingString:[phoneNumber sanitizedPhoneNumber]];
      
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]];
    }
    
    return NO;
}

BOOL FKInterAppOpenMessages(NSString *phoneNumber) {
    if (phoneNumber != nil) {
        NSString *appScheme = [kFKInterAppSchemeMessages stringByAppendingString:[phoneNumber sanitizedPhoneNumber]];
        
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
