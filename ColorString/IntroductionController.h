//
//  IntroductionController.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionView.h"

@protocol IntroductionDelegate <NSObject>

- (void)startPlaying;

@end

@interface IntroductionController : UIViewController
@property(nonatomic, assign)id<IntroductionDelegate> delegate;
@end
