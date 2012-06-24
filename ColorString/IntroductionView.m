//
//  IntroductionView.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntroductionView.h"

#define MainTitleText @"Color String"
#define SubTitleText @"Names of Colors,\nColors of Names"

#define StartButtonTitle @"start"
@implementation IntroductionView
@synthesize mainTitleLabel, subTitleLabel;
@synthesize startButton;
- (UILabel *)mainTitleLabel {
    if (mainTitleLabel) return mainTitleLabel;
    UILabel *label = [[[UILabel alloc] init] autorelease];
    UIFont *font = [UIFont boldSystemFontOfSize:44];
    [label setFont:font];
    UIColor *color = [UIColor colorWithWhite:0.9
                                       alpha:1.0f];
    [label setTextColor:color];
    [label setBackgroundColor:self.backgroundColor];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:MainTitleText];
    [self addSubview:label];
    mainTitleLabel = label;
    return mainTitleLabel;
}
- (UILabel *)subTitleLabel {
    if (subTitleLabel) return subTitleLabel;
    UILabel *label = [[[UILabel alloc] init] autorelease];
    UIFont *font = [UIFont systemFontOfSize:16];
    [label setFont:font];
    [label setTextColor:[UIColor grayColor]];
    [label setNumberOfLines:3];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setBackgroundColor:self.backgroundColor];
    [label setText:SubTitleText];
    [self addSubview:label];
    subTitleLabel = label;
    return subTitleLabel;
}
- (UIButton *)startButton {
    if (startButton) return startButton;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:StartButtonTitle
            forState:UIControlStateNormal];
    UIFont *font = [UIFont systemFontOfSize:23];
    [button.titleLabel setFont:font];
    [self addSubview:button];
    startButton = button;
    return startButton;
}
#pragma mark -
- (void)layoutSubviews {
    CGFloat x, y;
    CGFloat width = CGRectGetWidth(self.bounds);
    
    x = 0, y = 80;
    static const CGFloat mainTitleHeight = 50;
    [self.mainTitleLabel  setFrame:CGRectMake(x, y, width, mainTitleHeight)];
    y += mainTitleHeight;
    static const CGFloat subTitleHeight = 70;
    [self.subTitleLabel setFrame:CGRectMake(x, y, width, subTitleHeight)];
    
    static const CGFloat buttonWidth = 150, buttonHeight = 50;
    y = 260;
    x = (width - buttonWidth) / 2;
    [self.startButton setFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
    
}
- (id)init {
    self = [super init];
    if (self) {
        UIColor *color = [UIColor blackColor];
        [self setBackgroundColor:color];
        [self setNeedsLayout];
    }
    return self;
}
@end
