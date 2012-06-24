//
//  IntroductionController.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IntroductionController.h"


@interface IntroductionController(private)
@property(nonatomic, readonly)IntroductionView *view;
@end


@implementation IntroductionController
@synthesize delegate;
- (void)loadView {
    IntroductionView *view = [[[IntroductionView alloc] init] autorelease];
    [view.startButton addTarget:self.delegate
                         action:@selector(startPlaying) 
               forControlEvents:UIControlEventTouchUpInside];
    [self setView:view];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end


@implementation IntroductionController(private)
@dynamic view;
- (IntroductionView *)view {
    return (IntroductionView *)super.view;
}


@end