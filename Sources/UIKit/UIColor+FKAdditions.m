#import "UIColor+FKAdditions.h"

FKLoadCategory(UIColorFKAdditions);

@implementation UIColor (FKAdditions)

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Class Methods
////////////////////////////////////////////////////////////////////////

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
	int red = (hex >> 16) & 0xFF;
	int green = (hex >> 8) & 0xFF;
	int blue = (hex) & 0xFF;
	
	return [UIColor colorWithRed:red / 255.0f
						   green:green / 255.0f
							blue:blue / 255.0f
						   alpha:1.0f];
}

// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	
    if (![scanner scanHexInt:&hexNum]) {
        return nil; 
    }
    
	return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)randomColor {
    CGFloat red = (arc4random()%256)/255.0;
    CGFloat green = (arc4random()%256)/255.0;
    CGFloat blue = (arc4random()%256)/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Instance Methods
////////////////////////////////////////////////////////////////////////

- (CGColorSpaceModel)colorSpaceModel {
	return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents {
	switch (self.colorSpaceModel) {
		case kCGColorSpaceModelRGB:
		case kCGColorSpaceModelMonochrome:
			return YES;
            
		default:
			return NO;
	}
}

- (BOOL)getRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	CGFloat r,g,b,a;
	
	switch (self.colorSpaceModel) {
		case kCGColorSpaceModelMonochrome:
			r = g = b = components[0];
			a = components[1];
			break;
            
		case kCGColorSpaceModelRGB:
			r = components[0];
			g = components[1];
			b = components[2];
			a = components[3];
			break;
            
		default:	// We don't know how to handle this model
			return NO;
	}
	
	if (red) *red = r;
	if (green) *green = g;
	if (blue) *blue = b;
	if (alpha) *alpha = a;
	
	return YES;
}

- (CGFloat)red {
    assert(self.canProvideRGBComponents);
	
    const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat)green {
	assert(self.canProvideRGBComponents);
	
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    
	if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
    
	return c[1];
}

- (CGFloat)blue {
	assert(self.canProvideRGBComponents);
	
    const CGFloat *c = CGColorGetComponents(self.CGColor);
	
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) {
        return c[0];
    }
	
    return c[2];
}

- (CGFloat)white {
    assert(self.colorSpaceModel == kCGColorSpaceModelMonochrome);
	
    const CGFloat *c = CGColorGetComponents(self.CGColor);
	return c[0];
}

- (CGFloat)alpha {
	return CGColorGetAlpha(self.CGColor);
}

- (UInt32)RGBHex {
    assert(self.canProvideRGBComponents);
	
	CGFloat r,g,b,a;
    
	if (![self getRed:&r green:&g blue:&b alpha:&a]) {
        return 0; 
    }
	
	r = MIN(MAX(self.red, 0.0f), 1.0f);
	g = MIN(MAX(self.green, 0.0f), 1.0f);
	b = MIN(MAX(self.blue, 0.0f), 1.0f);
	
	return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

- (NSString *)stringRepresentation {
    assert(self.canProvideRGBComponents);
	
    NSString *result;
	
    switch (self.colorSpaceModel) {
		case kCGColorSpaceModelRGB:
			result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.red, self.green, self.blue, self.alpha];
			break;
            
		case kCGColorSpaceModelMonochrome:
			result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.white, self.alpha];
			break;
            
		default:
			result = nil;
	}
    
	return result;
}

- (NSString *)hexStringRepresentation {
	return [NSString stringWithFormat:@"%0.6X", self.RGBHex];
}

@end
