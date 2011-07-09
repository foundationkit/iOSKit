// Part of FoundationKit http://foundationk.it


#import "NKUniversal.h"

#define kNKDefaultIPadAppendix              @"@iPad"
#define kNKDefaultIPadLandscapeAppendix     @"-L"



NS_INLINE BOOL NKIsIPad() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}


NS_INLINE BOOL NKIsIPhone() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

NS_INLINE BOOL NKRotateOnIPad(UIInterfaceOrientation interfaceOrientation) {
    return NKIsIPad() || interfaceOrientation == UIInterfaceOrientationPortrait;
}

NS_INLINE CGRect NKRectMake(CGFloat xPhone, CGFloat yPhone, CGFloat widthPhone, CGFloat heightPhone, CGFloat xPad, CGFloat yPad, CGFloat widthPad, CGFloat heightPad) {
    return NKIsIPad() ? CGRectMake(xPad, yPad, widthPad, heightPad) : CGRectMake(xPhone, yPhone, widthPhone, heightPhone);
}

NS_INLINE CGSize NKSizeMake(CGFloat widthPhone, CGFloat heightPhone, CGFloat widthPad, CGFloat heightPad) {
    return NKIsIPad() ? CGSizeMake(widthPad, heightPad) : CGSizeMake(widthPhone, heightPhone);
}

NS_INLINE CGPoint NKPointMake(CGFloat xPhone, CGFloat yPhone, CGFloat xPad, CGFloat yPad) {
    return NKIsIPad() ? CGPointMake(xPad, yPad) : CGPointMake(xPhone, yPhone);
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Functions for managing device-specific Resources on iPhone/iPad
///////////////////////////////////////////////////////////////////////////////////////////////////////

NSString* NKDeviceSpecificImageName(NSString *imageName) {
	return NKDeviceSpecificImageNameWithAppendix(imageName, kNKDefaultIPadAppendix);
}

NSString* NKDeviceSpecificImageNameWithAppendix(NSString *imageName, NSString *appendix) {
    // seperate extension from imageName
	NSArray *parts = [imageName componentsSeparatedByString:@"."];
	// when on iPad, append "-iPad"
	NSString *iPadAppendix = NKIsIPad() ? appendix : @"";
    
	if (parts.count == 2) {
		return [NSString stringWithFormat:@"%@%@.%@", [parts objectAtIndex:0], iPadAppendix, [parts objectAtIndex:1]];
	} else if (parts.count == 1) {
		// append .png per default
		return [NSString stringWithFormat:@"%@%@.png", [parts objectAtIndex:0], iPadAppendix];
	}
    
	return nil;
}

NSString* NKDeviceSpecificImageNameForOrientation(NSString *imageName, UIInterfaceOrientation orientation) {
	return NKDeviceSpecificImageNameForOrientationWithAppendix(imageName, orientation, kNKDefaultIPadAppendix);
}

NSString* NKDeviceSpecificImageNameForOrientationWithAppendix(NSString *imageName, UIInterfaceOrientation orientation, NSString *appendix) {
    // seperate extension from imageName
	NSArray *parts = [imageName componentsSeparatedByString:@"."];
	// when on iPad, append appendix
	NSString *iPadAppendix = NKIsIPad() ? appendix : @"";
	// when on iPad and orientation is Landscape append landscape-appendix
	NSString *orientationAppendix = NKIsIPad() && UIInterfaceOrientationIsLandscape(orientation) ? kNKDefaultIPadLandscapeAppendix : @"";
    
	if (parts.count == 2) {
		return [NSString stringWithFormat:@"%@%@%@.%@", [parts objectAtIndex:0], iPadAppendix, orientationAppendix, [parts objectAtIndex:1]];
	} else if (parts.count == 1) {
		// append .png per default
		return [NSString stringWithFormat:@"%@%@%@.png", [parts objectAtIndex:0], iPadAppendix, orientationAppendix];
	}
    
	return nil;
}

NSString* NKDeviceSpecificNibName(NSString *name) {
	// when on iPad, append "-iPad"
	NSString *iPadAppendix = NKIsIPad() ? kNKDefaultIPadAppendix : @"";
	NSString *nibName = [NSString stringWithFormat:@"%@%@",name, iPadAppendix];
    
	// fallback: no iPad-specific nib file? -> use iPhone-Nib
	if([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"] == nil) {
		// even no iPhone-nib? -> use no nib => return nil
		if([[NSBundle mainBundle] pathForResource:name ofType:@"nib"] == nil) {
			return nil;
		}
        
		return name;
	}
    
	return nibName;
}