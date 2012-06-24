//
//  PlayEpilogeView.h
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayEpilogeView : UIView

@property(nonatomic, readonly)UILabel *scoreLabel, *bestScoreLabel;
@property(nonatomic, readonly)UIButton *retryButton;
- (void)setScore:(NSInteger)score;
- (void)setBestScore:(NSInteger)score;
@end
