// Part of iOSKit http://foundationk.it
//
// Derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit

CGGradientRef FKCreateGradientWithColors(NSArray *colors);
CGGradientRef FKCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations);

void FKDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect);
void FKDrawRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerRadius);