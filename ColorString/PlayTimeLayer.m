//
//  PlayTimeLayer.m
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayTimeLayer.h"
#import "ColorStringFuctions.h"


CABasicAnimation *animationOnColor(CGColorRef fromColor,
                                   CGColorRef toColor);

void *pauseAnimationOnLayer(CALayer *layer);
void *resumeAnimationOnLayer(CALayer *layer);



@implementation PlayTimeLayer
@synthesize filledLayer, remainLayer, outerLayer, outerLayer2;
@synthesize barColor1, barColor2;
- (CALayer *)filledLayer {
    if (filledLayer) return filledLayer;
    CALayer *layer = [CALayer layer];
    

    [layer setBackgroundColor:self.barColor1];

    [self addSublayer:layer];
    filledLayer = layer;
    return filledLayer;
}
- (CALayer *)remainLayer {
    if (remainLayer) return remainLayer;
    CALayer *layer = [CALayer layer];
    [layer setBackgroundColor:[UIColor darkGrayColor].CGColor];
    [self insertSublayer:layer
                   above:self.filledLayer];
    remainLayer = layer;
    return remainLayer;
}
- (CALayer *)outerLayer {
    if (outerLayer) return outerLayer;
    CALayer *layer = [CALayer layer];
    [layer setBackgroundColor:[UIColor blackColor].CGColor];
    [self addSublayer:layer];
    outerLayer = layer;
    return outerLayer;
}
- (CALayer *)outerLayer2 {
    if (outerLayer2 ) return outerLayer2;
    CALayer *layer = [CALayer layer];
    [layer setBackgroundColor:[UIColor blackColor].CGColor];
    [self addSublayer:layer];
    outerLayer2 = layer;

    
    return outerLayer2;
}
- (CGColorRef)barColor1 {
    UIColor *color = [UIColor colorWithRed:0
                                     green:1
                                      blue:0.4
                                     alpha:1];
    return color.CGColor;
}
- (CGColorRef)barColor2 {
    UIColor *color = [UIColor colorWithRed:1
                                     green:0.2
                                      blue:0.4
                                     alpha:1];
    return color.CGColor;
}

#pragma mark -
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}
static const CGFloat remainWidth = 1;

- (void)layoutSublayers {
    [self.filledLayer setFrame:self.bounds];
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat x = width - remainWidth, y = 0;
    [self.remainLayer setFrame:CGRectMake(x, y, remainWidth * 2, height)];
    
    x = width;
    [self.outerLayer setFrame:CGRectMake(x, y, width, height)];
    [self.outerLayer2 setFrame:CGRectMake(-10, y, 10, height)];
}

#pragma mark -
- (void)startWithInterval:(NSTimeInterval)interval {
    [self setNeedsDisplay];
    [self resume];
    
    CGFloat scale = CGRectGetWidth(self.bounds) / remainWidth;
    CATransform3D transform = CATransform3DMakeScale(scale, 1, 1);

    
    CABasicAnimation *shrinkAnimation = transformAnimation(transform, 
                                                     CATransform3DIdentity);
    shrinkAnimation.duration = interval;
    shrinkAnimation.fillMode = kCAFillModeForwards;
    [self.remainLayer addAnimation:shrinkAnimation
                            forKey:@"shrink"];
    
    CABasicAnimation *reddenAnimation = animationOnColor(self.barColor1,
                                                         self.barColor2);
    reddenAnimation.duration = interval;
    [self.filledLayer addAnimation:reddenAnimation
                            forKey:@"redden"];

    
    
    [self display];
}
- (void)pause {
    pauseAnimationOnLayer(self.filledLayer);
    pauseAnimationOnLayer(self.remainLayer);
}
- (void)resume {
    resumeAnimationOnLayer(self.filledLayer);
    resumeAnimationOnLayer(self.remainLayer);
}
@end


CABasicAnimation *animationOnColor(CGColorRef fromColor,
                                   CGColorRef toColor)
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [animation setFromValue:(id)fromColor];
    [animation setToValue:(id)toColor];
    return animation;
}
void *pauseAnimationOnLayer(CALayer *layer) {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime()
                                           toLayer:nil];
    [layer setSpeed:0.0f];
    [layer setTimeOffset:pausedTime];
    return nil;
}
void *resumeAnimationOnLayer(CALayer *layer) {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() 
                                             fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
    return nil;
}




