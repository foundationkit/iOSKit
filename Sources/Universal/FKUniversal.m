// Part of iOSKit http://foundationk.it


#import "FKUniversal.h"

#define kFKDefaultIPadAppendix              @"@iPad"
#define kFKDefaultIPadLandscapeAppendix     @"-L"



NS_INLINE BOOL $isPad(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}


NS_INLINE BOOL $isPhone(void) {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

NS_INLINE BOOL FKRotateOnPad(UIInterfaceOrientation interfaceOrientation) {
    return $isPad() || interfaceOrientation == UIInterfaceOrientationPortrait;
}

NS_INLINE CGRect FKRectMake(CGFloat xPhone, CGFloat yPhone, CGFloat widthPhone, CGFloat heightPhone, CGFloat xPad, CGFloat yPad, CGFloat widthPad, CGFloat heightPad) {
    return $isPad() ? CGRectMake(xPad, yPad, widthPad, heightPad) : CGRectMake(xPhone, yPhone, widthPhone, heightPhone);
}

NS_INLINE CGSize FKSizeMake(CGFloat widthPhone, CGFloat heightPhone, CGFloat widthPad, CGFloat heightPad) {
    return $isPad() ? CGSizeMake(widthPad, heightPad) : CGSizeMake(widthPhone, heightPhone);
}

NS_INLINE CGPoint FKPointMake(CGFloat xPhone, CGFloat yPhone, CGFloat xPad, CGFloat yPad) {
    return $isPad() ? CGPointMake(xPad, yPad) : CGPointMake(xPhone, yPhone);
}



///////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Functions for managing device-specific Resources on iPhone/iPad
///////////////////////////////////////////////////////////////////////////////////////////////////////

NSString* FKDeviceSpecificImageName(NSString *imageName) {
	return FKDeviceSpecificImageNameWithAppendix(imageName, kFKDefaultIPadAppendix);
}

NSString* FKDeviceSpecificImageNameWithAppendix(NSString *imageName, NSString *appendix) {
    // seperate extension from imageName
	NSArray *parts = [imageName componentsSeparatedByString:@"."];
	// when on iPad, append "-iPad"
	NSString *iPadAppendix = $isPad() ? appendix : @"";
    
	if (parts.count == 2) {
		return [NSString stringWithFormat:@"%@%@.%@", [parts objectAtIndex:0], iPadAppendix, [parts objectAtIndex:1]];
	} else if (parts.count == 1) {
		// append .png per default
		return [NSString stringWithFormat:@"%@%@.png", [parts objectAtIndex:0], iPadAppendix];
	}
    
	return nil;
}

NSString* FKDeviceSpecificImageNameForOrientation(NSString *imageName, UIInterfaceOrientation orientation) {
	return FKDeviceSpecificImageNameForOrientationWithAppendix(imageName, orientation, kFKDefaultIPadAppendix);
}

NSString* FKDeviceSpecificImageNameForOrientationWithAppendix(NSString *imageName, UIInterfaceOrientation orientation, NSString *appendix) {
    // seperate extension from imageName
	NSArray *parts = [imageName componentsSeparatedByString:@"."];
	// when on iPad, append appendix
	NSString *iPadAppendix = $isPad() ? appendix : @"";
	// when on iPad and orientation is Landscape append landscape-appendix
	NSString *orientationAppendix = $isPad() && UIInterfaceOrientationIsLandscape(orientation) ? kFKDefaultIPadLandscapeAppendix : @"";
    
	if (parts.count == 2) {
		return [NSString stringWithFormat:@"%@%@%@.%@", [parts objectAtIndex:0], iPadAppendix, orientationAppendix, [parts objectAtIndex:1]];
	} else if (parts.count == 1) {
		// append .png per default
		return [NSString stringWithFormat:@"%@%@%@.png", [parts objectAtIndex:0], iPadAppendix, orientationAppendix];
	}
    
	return nil;
}

NSString* FKDeviceSpecificNibName(NSString *name) {
	// when on iPad, append "-iPad"
	NSString *iPadAppendix = $isPad() ? kFKDefaultIPadAppendix : @"";
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