//
//  PlayName.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ColorStringEnums.h"

@interface PlayCardLayer : CALayer
@property(nonatomic, readonly)CATextLayer *textLayer;
@property(nonatomic)PlayColor fontColor;
@property(nonatomic)PlayColor colorName;
@property(nonatomic)BOOL focused;
@property(nonatomic)BOOL isTarget;
- (void)shake;
@end
