#import "UIView+FKNoise.h"
#include <stdlib.h>

#define kFKNoiseTileDimension     40.f
#define kFKNoiseIntensity         250
#define kFKNoiseDefaultOpacity    0.4f
#define kFKNoisePixelWidth        0.3f

static UIImage * fk_noiseImage;

////////////////////////////////////////////////////////////////////////
#pragma mark - FKNoiseLayer Class Extension
////////////////////////////////////////////////////////////////////////

@interface FKNoiseLayer ()

+ (UIImage *)noiseTileImage;
+ (void)drawPixelInContext:(CGContextRef)context
                     point:(CGPoint)point 
                     width:(CGFloat)width 
                   opacity:(CGFloat)opacity
                whiteLevel:(CGFloat)whiteLevel;

@end

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView+FKNoise
////////////////////////////////////////////////////////////////////////

@implementation UIView (FKNoise)

- (void)applyNoise {
    [self applyNoiseWithOpacity:kFKNoiseDefaultOpacity];
}

- (void)applyNoiseWithOpacity:(CGFloat)opacity {
    FKNoiseLayer *noiseLayer = [FKNoiseLayer noiseLayerWithFrame:self.bounds opacity:opacity];
    
    [self.layer insertSublayer:noiseLayer atIndex:0];
}

- (void)drawNoiseWithOpacity:(CGFloat)opacity {
    [self drawNoiseWithOpacity:opacity blendMode:kCGBlendModeNormal];
}

- (void)drawNoiseWithOpacity:(CGFloat)opacity blendMode:(CGBlendMode)blendMode {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:self.bounds];
    
    CGContextSaveGState(context);
    {
        CGContextAddPath(context, [path CGPath]);
        CGContextClip(context);
        CGContextSetBlendMode(context, blendMode);
        CGContextSetAlpha(context, opacity);
        [[FKNoiseLayer noiseTileImage] drawAsPatternInRect:self.bounds];
    }
    CGContextRestoreGState(context);    
}

@end

////////////////////////////////////////////////////////////////////////
#pragma mark - FKNoiseLayer
////////////////////////////////////////////////////////////////////////

@implementation FKNoiseLayer

+ (FKNoiseLayer *)noiseLayerWithFrame:(CGRect)frame opacity:(CGFloat)opacity {
    FKNoiseLayer *noiseLayer = [[FKNoiseLayer alloc] init];
    
    noiseLayer.masksToBounds = YES;
    noiseLayer.frame = frame;
    noiseLayer.opacity = opacity;
    
    return noiseLayer;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)context {
    UIGraphicsPushContext(context);
    {
        [[FKNoiseLayer noiseTileImage] drawAsPatternInRect:self.bounds];
    }
    UIGraphicsPopContext();
}

+ (void)drawPixelInContext:(CGContextRef)context
                     point:(CGPoint)point
                     width:(CGFloat)width
                   opacity:(CGFloat)opacity
                whiteLevel:(CGFloat)whiteLevel {
    
    CGColorRef fillColor = [UIColor colorWithWhite:whiteLevel alpha:opacity].CGColor;
    CGRect pointRect = CGRectMake(point.x - (width/2), point.y - (width/2), width, width);
    
    CGContextSetFillColor(context, CGColorGetComponents(fillColor));
    CGContextFillEllipseInRect(context, pointRect);
}

+ (UIImage *)noiseTileImage {
    static dispatch_once_t onceToken;
    
#ifndef __clang_analyzer__
    
    dispatch_once(&onceToken, ^{
        CGFloat imageScale = [UIScreen mainScreen].scale;
        NSUInteger imageDimension = (NSUInteger)(imageScale * kFKNoiseTileDimension);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(nil,imageDimension,imageDimension,8,0,colorSpace,kCGImageAlphaPremultipliedLast);
        CFRelease(colorSpace);
        
        for (NSUInteger i=0; i<(kFKNoiseTileDimension * kFKNoiseIntensity); i++) {
            int x = (int)(arc4random() % (imageDimension + 1));
            int y = (int)(arc4random() % (imageDimension + 1));
            int opacity = arc4random() % 100;
            CGFloat whiteLevel = arc4random() % 100;
            
            [FKNoiseLayer drawPixelInContext:context 
                                       point:CGPointMake(x, y)
                                       width:(kFKNoisePixelWidth * imageScale) 
                                     opacity:(opacity) 
                                  whiteLevel:(whiteLevel/100.f)];
        }
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        
        fk_noiseImage = [[UIImage alloc] initWithCGImage:imageRef scale:imageScale orientation:UIImageOrientationUp];
    });
    
#endif
    
    return fk_noiseImage;
}

@end