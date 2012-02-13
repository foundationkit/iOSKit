#import "UIColor+FKAdditions.h"

FKLoadCategory(UIColorFKAdditions);

@implementation UIColor (FKAdditions)

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
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

+ (UIColor *)inverseColorToColor:(UIColor *)color {
    FKAssert(color != nil, @"Cannot compute inverse color to nil");
    
    // do not crash when assertions are off
    if (color == nil) {
        return nil;
    }
    
    CGColorRef oldCGColor = color.CGColor;
    size_t numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);
    
    // can not invert - the only component is the alpha
    // e.g. self == [UIColor groupTableViewBackgroundColor]
    if (numberOfComponents == 1) {
        return [UIColor colorWithCGColor:oldCGColor];
    }
    
    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    CGFloat newComponentColors[numberOfComponents];
    int i = numberOfComponents - 1;
    newComponentColors[i] = oldComponentColors[i]; // alpha
    
    while (--i >= 0) {
        newComponentColors[i] = 1 - oldComponentColors[i];
    }
    
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    
    return newColor;
}

+ (CGFloat)colorDifferenceBetweenColor:(UIColor *)color1 color:(UIColor *)color2 {
    FKAssert(color1 != nil && color2 != nil, @"Colors must be non-nil to calculate difference");
    
    // do not crash when assertions are off
    if (color1 == nil || color2 == nil) {
        return CGFLOAT_MAX;
    }
    
    CGFloat red1, red2;
    CGFloat green1, green2;
    CGFloat blue1, blue2;
    
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:NULL];
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:NULL];
    
    // http://particletree.com/notebook/calculating-color-contrast-for-legible-text/
    return ((MAX(red1, red2) - MIN(red1, red2)) +
            (MAX(green1, green2) - MIN(green1, green2)) +
            (MAX(blue1, blue2) - MIN(blue1, blue2)));
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIColor+FKAdditions
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
    assert(self.canProvideRGBComponents);
    
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
	
	if (red != NULL) {
        *red = r;
    }
    
	if (green != NULL) {
        *green = g; 
    }
    
	if (blue != NULL) {
        *blue = b; 
    }
    
	if (alpha != NULL) {
        *alpha = a; 
    }
	
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

- (CGFloat)brightness {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    
    [self getRed:&red green:&green blue:&blue alpha:NULL];
    
    // http://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
    // http://particletree.com/notebook/calculating-color-contrast-for-legible-text/
    return ((red * 299.f) + (green * 587.f) + (blue * 114.f)) / 1000.f;
}

- (UIColor *)inverseColor {
    return [[self class] inverseColorToColor:self];
}

- (CGFloat)colorDifferenceToColor:(UIColor *)color {
    return [[self class] colorDifferenceBetweenColor:self color:color];
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
