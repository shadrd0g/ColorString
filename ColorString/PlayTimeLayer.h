//
//  PlayTimeLayer.h
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PlayTimeLayer : CALayer
@property(nonatomic, readonly)CALayer *filledLayer, *remainLayer, *outerLayer, *outerLayer2;
@property(nonatomic, readonly)CGColorRef barColor1, barColor2;
- (void)startWithInterval:(NSTimeInterval)interval;
- (void)pause;
- (void)resume;
@end
