//
//  PlayEpilogeView.m
//  ColorString
//
//  Created by Taka Okunishi on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayEpilogeView.h"
#define RetryTitle @"Retry"
#define ScoreFormat @"Your Score : %d"
#define BestScoreFormat @"Best Score : %d"
@implementation PlayEpilogeView
@synthesize scoreLabel, bestScoreLabel, retryButton;
- (UILabel *)scoreLabel {
    if (scoreLabel) return scoreLabel;
    UILabel *label = [[[UILabel alloc] init] autorelease];
    [label setBackgroundColor:self.backgroundColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [self addSubview:label];
    scoreLabel = label;
    return scoreLabel;
}
- (UILabel *)bestScoreLabel {
    if (bestScoreLabel) return bestScoreLabel;
    UILabel *label = [[[UILabel alloc] init] autorelease];
    [label setBackgroundColor:self.backgroundColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [self addSubview:label];
    bestScoreLabel = label;
    return bestScoreLabel;
}
- (UIButton *)retryButton {
    if (retryButton) return retryButton;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:RetryTitle
            forState:UIControlStateNormal];
    [self addSubview:button];
    retryButton = button;
    return retryButton;
}
- (void)setScore:(NSInteger)score {
    NSString *text = [NSString stringWithFormat:ScoreFormat, score];
    [self.scoreLabel setText:text];
}
- (void)setBestScore:(NSInteger)score {
    NSString *text = [NSString stringWithFormat:BestScoreFormat, score];
    [self.bestScoreLabel setText:text];
}
#pragma mark -
- (void)layoutSubviews {
    CGFloat x, y;
    CGFloat width = CGRectGetWidth(self.bounds);
    static const CGFloat margin = 20;
    static const CGFloat scoreHeight = 24;
    x = 0, y = margin;
    [self.scoreLabel setFrame:CGRectMake(x, y, width, scoreHeight)];
    y += scoreHeight;
    [self.bestScoreLabel setFrame:CGRectMake(x, y, width, scoreHeight)];
    y = 90;
    static const CGFloat buttonWidth = 120, buttonHeight = 38;
    x = (width - buttonWidth) / 2;
    [self.retryButton setFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
}
- (id)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}
@end
