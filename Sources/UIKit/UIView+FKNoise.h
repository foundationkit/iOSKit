// Part of iOSKit http://foundationk.it
//
// Derived from Jason Morrissey's BSD-Licensed JMNoise: https://github.com/jasonmorrissey/JMNoise

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 This category makes it very easy to add a noise texture to UIViews.
 It's performed entirely using Core Graphics.
 */
@interface UIView (FKNoise)

- (void)applyNoise;
- (void)applyNoiseWithOpacity:(CGFloat)opacity;

- (void)drawNoiseWithOpacity:(CGFloat)opacity;
- (void)drawNoiseWithOpacity:(CGFloat)opacity blendMode:(CGBlendMode)blendMode;

@end


@interface FKNoiseLayer : CALayer

+ (FKNoiseLayer *)noiseLayerWithFrame:(CGRect)frame opacity:(CGFloat)opacity;

@end