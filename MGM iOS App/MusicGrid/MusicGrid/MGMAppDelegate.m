//
//  MGMAppDelegate.m
//  MusicGrid
//
//  Created by Jonathan Fox on 6/6/14.
//  Copyright (c) 2014 Jonathan Fox. All rights reserved.
//

#import "MGMAppDelegate.h"
#import "MGMLogInVC.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MGMViewController.h"
#import <Parse/Parse.h>

@implementation MGMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // If you have not added the -ObjC linker flag, you may need to uncomment the following line because
    // Nib files require the type to have been loaded before they can do the wireup successfully.
    // http://stackoverflow.com/questions/1725881/unknown-class-myclass-in-interface-builder-file-error-at-runtime
    [FBProfilePictureView class];
    [FBLoginView class];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"QpZ5YJydsBbgJHFEgFYsAmQd9eXWJdNQ7Yczcfe6"
                  clientKey:@"jvqjGXG2ObTf6eRNfnqC5GNpziCAsqnkF5OjBCkm"];

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [PFUser enableAutomaticUser];

//    PFUser * user = [PFUser currentUser];
//    NSString * username = user.username;
    
//    if (username == nil) {
//        nc = [[UINavigationController alloc]initWithRootViewController:[[SLFLogInVC alloc]initWithNibName:nil bundle:nil]];
//        nc.navigationBarHidden = YES;
//        
//    }else{
//        nc = [[UINavigationController alloc]initWithRootViewController:[[SLFTableVC alloc]initWithStyle:UITableViewStylePlain]];

    
    MGMViewController * rvc = [[MGMViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:rvc];
    
    
    self.window.rootViewController = nc;

    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                    fallbackHandler:^(FBAppCall *call) {
                        NSLog(@"In fallback handler");
                    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // FBSample logic
    // Call the 'activateApp' method to log an app event for use in analytics and advertising reporting.
    [FBAppEvents activateApp];
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


@end
