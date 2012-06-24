//
//  RootController.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionController.h"
#import "PlayController.h"
#import "GADBannerView.h"
#import <iAd/iAd.h>
@interface RootController : UIViewController<IntroductionDelegate,ADBannerViewDelegate, GADBannerViewDelegate>
@property(nonatomic, retain, readonly)IntroductionController *introductionController;
@property(nonatomic, retain, readonly)PlayController *playController;
@property(nonatomic, retain, readonly)GADBannerView *bannerView;
@property(nonatomic, retain)ADBannerView *iAdBanner;
@end
