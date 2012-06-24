//
//  PlayMessageLayer.h
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ColorStringEnums.h"

@interface PlayMessageLayer : CALayer
@property(nonatomic, readonly)CATextLayer *textLayer;
@property(nonatomic)PlayMessage message;
@property(nonatomic)CGSize fitSize;
@end
