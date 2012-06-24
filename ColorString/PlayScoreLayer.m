//
//  ScoreLayer.m
//  ColorString
//
//  Created by Taka Okunishi on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayScoreLayer.h"
#define Title @"score: "
@implementation PlayScoreLayer
@synthesize titleLayer, numberLayer;
- (CATextLayer *)titleLayer {
    if (titleLayer) return titleLayer;
    CATextLayer *layer = [CATextLayer layer];
    [layer setFontSize:15];
    [layer setString:Title];
    [layer setAlignmentMode:kCAAlignmentLeft];
    [self addSublayer:layer];
    titleLayer = layer;
    return titleLayer;
}
- (CATextLayer *)numberLayer {
    if (numberLayer) return numberLayer;
    CATextLayer *layer = [CATextLayer layer];
    [layer setFontSize:17];
    [layer setAlignmentMode:kCAAlignmentRight];
    [self addSublayer:layer];
    numberLayer = layer;
    return numberLayer;
}
- (void)setScore:(NSInteger)score {
    [self.numberLayer setString:[NSString stringWithFormat:@"%d", score]];
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
- (void)layoutSublayers {
    CGFloat x, y;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    static const CGFloat titleWidth = 40, textHeight = 30;
    x = 0, y = (height - textHeight) / 2;
    [self.titleLayer setFrame:CGRectMake(x, y, titleWidth, textHeight)];
    x += titleWidth;
    CGFloat numberWidth = width - titleWidth;
    [self.numberLayer setFrame:CGRectMake(x, y, numberWidth, textHeight)];
}
@end
