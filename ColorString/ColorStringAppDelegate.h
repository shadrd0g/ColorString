//
//  ColorStringAppDelegate.h
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"
@interface ColorStringAppDelegate : NSObject <UIApplicationDelegate>

@property(nonatomic, readonly)UIWindow *window;
@property(nonatomic, readonly)RootController *rootController;

@end
