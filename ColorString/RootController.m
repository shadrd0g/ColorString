//
//  RootController.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootController.h"
#import "RootView.h"

#define PublisherId @"a14e86968804f94"
#define PublisherId2 @"a14e7fbff39fb71"
@interface RootController(private)
@property(nonatomic, readonly)RootView *view;

@end

@implementation RootController
@synthesize introductionController, playController;
@synthesize bannerView;
@synthesize iAdBanner;
- (IntroductionController *)introductionController {
    if (introductionController) return introductionController;
    introductionController = [[IntroductionController alloc] init];
    [introductionController setDelegate:self];
    return introductionController;
}
- (PlayController *)playController {
    if (playController) return playController;
    playController = [[PlayController alloc] init];
    return playController;
}
-(GADBannerView *)bannerView {
    if (bannerView) return bannerView;
    CGRect frame = CGRectMake(0, 0, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height);
    GADBannerView *view = [[[GADBannerView alloc] initWithFrame:frame] autorelease];
    [view setAdUnitID:PublisherId2];
    [view setRootViewController:self];
    bannerView = view;
    return bannerView;
}
- (ADBannerView *)iAdBanner {
    if (iAdBanner) return iAdBanner;
    iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 410, 320, 50)];
    iAdBanner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    iAdBanner.delegate = self;
    return iAdBanner;
}


#pragma mark -
- (void)dealloc {
    [introductionController release];
    [playController release];
    [bannerView release];
    [iAdBanner release];
    [super dealloc];
}


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
- (void)loadView {
    RootView *view = [[[RootView alloc] init] autorelease];
    [view setDisplayView:self.introductionController.view];
    [view setBannerView:self.bannerView];
    [self setView:view];
}
- (void)viewDidLoad {
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
}
#pragma mark -
- (void)startPlaying {
    [self.view setDisplayView:self.playController.view];
    [self.playController viewDidAppear:YES];
}

- (void)adViewDidReceiveAd:(GADBannerView *)view {
    
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    [self.bannerView removeFromSuperview];
    [self.view addSubview:self.iAdBanner];
}

- (void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error
{
    
    [banner removeFromSuperview];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            return YES;
            break;
            
        default:
            break;
    }
    return NO;
}
@end



@implementation RootController(private);
@dynamic view;

- (RootView *)view {
    return (RootView *)super.view;
}

@end