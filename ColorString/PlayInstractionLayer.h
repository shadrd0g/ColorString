//
//  InstractionLayer.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ColorStringEnums.h"


@interface PlayInstractionLayer : CALayer
@property(nonatomic, readonly)CATextLayer *textLayer1, *textLayer2;
@property(nonatomic, readonly)CGColorRef textColor;
- (void)setInstractionWithMode:(PlayMode)mode
                         color:(PlayColor)color;

@end
