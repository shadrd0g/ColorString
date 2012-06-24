//
//  PlayView.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayTimeLayer.h"
#import "PlayInstractionLayer.h"
#import "PlayMessageLayer.h"
#import "PlayCardLayer.h"
#import "PlayScoreLayer.h"

@interface PlayView : UIView
@property(nonatomic, readonly)PlayTimeLayer *timeLayer;
@property(nonatomic, readonly)PlayInstractionLayer *instractionLayer;
@property(nonatomic, readonly)PlayMessageLayer *messageLayer;
@property(nonatomic, readonly)NSArray *cards;
@property(nonatomic, readonly)PlayScoreLayer *scoreLayer;

- (PlayCardLayer *)hitCard:(CGPoint)point;
- (void)hideAllCards;
- (void)showBlockerViewFromRight:(UIView *)blockerView;
- (void)hideBlockerView;

- (void)showModalBox:(UIView *)modalBox;
- (void)hideModalBox;

- (void)showMessage:(PlayMessage)message
           position:(CGPoint)position;
- (void)hideMessage;
@end
