//
//  ScoreLayer.h
//  ColorString
//
//  Created by Taka Okunishi on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface PlayScoreLayer : CALayer
@property(nonatomic, readonly)CATextLayer *titleLayer, *numberLayer;
- (void)setScore:(NSInteger)score;
@end
