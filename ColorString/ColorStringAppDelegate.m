//
//  ColorStringAppDelegate.m
//  ColorString
//
//  Created by Taka Okunishi on 10/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ColorStringAppDelegate.h"
#define BestScoreKey @"bestScore"

@implementation ColorStringAppDelegate
@synthesize window;
@synthesize rootController;
- (UIWindow *)window {
    if (window) return window;
    window = [[UIWindow alloc] init];
    CGRect frame = [[UIScreen mainScreen] bounds];
    [window setFrame:frame];
    return window;
}
- (RootController *)rootController {
    if (rootController) return rootController;
    rootController = [[RootController alloc] init];
    return rootController;
}

#pragma mark -
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSInteger bestScore = [[NSUserDefaults standardUserDefaults] integerForKey:BestScoreKey];
    [self.rootController.playController setBestScore:bestScore];
    [self.window setRootViewController:self.rootController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    NSInteger bestScore = self.rootController.playController.bestScore;
    [[NSUserDefaults standardUserDefaults] setInteger:bestScore
                                               forKey:BestScoreKey];

    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)dealloc
{
    [window release];
    [rootController release];
    [super dealloc];
}

@end
