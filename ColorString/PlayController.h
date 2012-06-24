//
//  PlayController.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayView.h"
#import "PlayTimeupView.h"
#import "PlayEpilogeView.h"

@interface PlayController : UIViewController
@property(nonatomic, assign)PlayCardLayer *cardInFocus;
@property(nonatomic, readonly)NSMutableArray *unsolvedCards;
@property(nonatomic, assign)NSTimer *timer;
@property(nonatomic, retain, readonly)PlayTimeupView *timeupView;
@property(nonatomic, retain, readonly)PlayEpilogeView *epilogView;
@property(nonatomic)BOOL interactionDiabled;
@property(nonatomic)NSInteger bestScore, score;
@property(nonatomic, readonly)NSInteger currentLevel;
@end
