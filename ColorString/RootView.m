//
//  RootView.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootView.h"

@implementation RootView
@synthesize displayView, bannerView;
- (void)setDisplayView:(UIView *)view {
    if ([displayView isEqual:view]) return;
    [displayView removeFromSuperview];
    [self addSubview:view];
    displayView = view;
}
- (void)setBannerView:(UIView *)view {
    if ([bannerView isEqual:view]) return;
    [bannerView removeFromSuperview];
    [self addSubview:view];
    bannerView = view;
}
- (void)layoutSubviews {
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat bannerHeight = CGRectGetHeight(self.bannerView.frame);
    CGFloat displayHeight = height - bannerHeight;
    CGFloat x = 0 , y = 0;
    [self.displayView setFrame:CGRectMake(x, y, width, displayHeight)];
    y += displayHeight;
    [self.bannerView setFrame:CGRectMake(x, y, width, bannerHeight)];
}
@end
