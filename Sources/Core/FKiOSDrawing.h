// Part of iOSKit http://foundationk.it
//
// Partly derived from Sam Soffes' Custom-Licensed SSToolkit: http://github.com/samsoffes/sstoolkit
// Partly derived from Tim Oliver's Blog-Post: http://www.tim-oliver.com/2011/10/23/creating-the-uitableview-bevel-effect-in-coregraphics/

CGGradientRef FKCreateGradientWithColors(NSArray *colors);
CGGradientRef FKCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations);

void FKDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect);
void FKDrawRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerRadius);
