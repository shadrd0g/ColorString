//
//  PlayTimeupView.m
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayTimeupView.h"
#define TimeupText @"TIME UP"

@implementation PlayTimeupView
@synthesize textLayer;
- (CATextLayer *)textLayer {
    if (textLayer) return textLayer;
    CATextLayer *layer = [CATextLayer  layer];
    [layer setString:TimeupText];
    [layer setAlignmentMode:kCAAlignmentCenter];
    [layer setForegroundColor:[UIColor redColor].CGColor];
    [self.layer addSublayer:layer];
    textLayer = layer;
    return textLayer;
}

#pragma mark - 
- (id)init {
    self = [super init];
    if (self) {
        UIColor *color = [UIColor colorWithWhite:0.1
                                           alpha:0.8];
        [self setBackgroundColor:color];
    }
    return self;
}
- (void)layoutSubviews {
    CGFloat x, y;
    x = 0, y = 100;
    static const CGFloat textHeight = 40;
    CGFloat width = CGRectGetWidth(self.bounds);
    [self.textLayer setFrame:CGRectMake(x, y, width, textHeight)];

}

@end
