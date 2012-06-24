//
//  PlayName.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayCardLayer.h"
#import "ColorStringFuctions.h"
#define BoldFont @"Helvetica-Bold"

CAKeyframeAnimation *shakeAnimation(CATransform3D transform);

@implementation PlayCardLayer
@synthesize textLayer;
@synthesize fontColor, colorName;
@synthesize focused;
@synthesize isTarget;
- (CATextLayer *)textLayer {
    if (textLayer) return textLayer;
    CATextLayer *layer = [CATextLayer layer];
    [layer setAlignmentMode:kCAAlignmentCenter];
    [layer setFont:BoldFont];
    [self addSublayer:layer];
    textLayer = layer;
    return textLayer;
}
- (void)setFontColor:(PlayColor)color {
    fontColor = color;
    CGColorRef CGColor = CGColorWithColor(color);
    [self.textLayer setForegroundColor:CGColor];
}
- (void)setColorName:(PlayColor)color {
    colorName = color;
    NSString *string = nameOfColor(color);
    [self.textLayer setString:string];
}

- (void)setFocused:(BOOL)newFlg {
    focused =newFlg;
    CGFloat fontSize;
    UIColor *backgroundColor;
    if(focused){
        backgroundColor = [UIColor colorWithWhite:0.48
                                            alpha:1];
        fontSize = 29;
    }else {
        backgroundColor = [UIColor colorWithWhite:0.08
                                            alpha:1];
        fontSize = 23;
    };
    [self setBackgroundColor:backgroundColor.CGColor];
    [self.textLayer setFontSize:fontSize];
}

#pragma mark - 
- (id)init
{
    self = [super init];
    if (self) {
        self.focused = NO;
        [self setBorderColor:[UIColor grayColor].CGColor];
        [self setBorderWidth:1.0f];
    }
    return self;
}
- (void)layoutSublayers {
    CGFloat widht = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    static const CGFloat textHeight = 25;
    
    CGFloat x, y;
    x = 0, y = (height - textHeight) / 2;
    
    [self.textLayer setFrame:CGRectMake(x, y, widht, textHeight)];
}
#pragma mark -
- (void)shake {
    static const CGFloat zDistance = 100;
    CATransform3D transform = self.transform;
    transform.m34 = 1 / - zDistance;
    [self setTransform:transform];
    
    CAKeyframeAnimation *animation = shakeAnimation(self.transform);
    
    static CGFloat duration = 0.1;
    animation.duration = duration;
    animation.repeatCount = 2;
    
    [self addAnimation:animation
                forKey:@"spin"];
}


@end

CAKeyframeAnimation *shakeAnimation(CATransform3D transform) {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform1, transform2, transform3, transform4;
    transform1 = transform;
    static const CGFloat tx = 8;
    transform2 = CATransform3DTranslate(transform, tx, 0, 0);
    //CATransform3DRotate(transform, M_PI, 0, 1, 0);
    transform3 = CATransform3DTranslate(transform, 0, 0, 0);
    transform4 = CATransform3DTranslate(transform, -tx, 0, 0);
    //CATransform3DRotate(transform, M_PI * 2, 0, 1, 0);
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:transform1],
                        [NSValue valueWithCATransform3D:transform2],
                        [NSValue valueWithCATransform3D:transform3],
                        [NSValue valueWithCATransform3D:transform4],
                        nil];
    return animation;
}



