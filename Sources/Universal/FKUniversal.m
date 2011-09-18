#import "FKUniversal.h"

#define kFKDefaultIPadAppendix              @"@iPad"
#define kFKDefaultIPadLandscapeAppendix     @"-L"


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