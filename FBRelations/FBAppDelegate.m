//
//  FBAppDelegate.m
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBAppDelegate.h"
#import "FBUserDetailViewController.h"
#import "FBAPI.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBBeaconManager.h"

@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [FBBeaconManager sharedInstance];
  FBUserDetailViewController *userDetailViewController = [[FBUserDetailViewController alloc] initWithUserId:@"me"];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userDetailViewController];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = navigationController;
  self.window.backgroundColor = WHITE_COLOR;
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  [FBSession.activeSession setStateChangeHandler:
   ^(FBSession *session, FBSessionState state, NSError *error) {
     if ( state == FBSessionStateOpen ) {
       [[NSNotificationCenter defaultCenter] postNotificationName:kSessionOpenNotification object:nil];
     }
   }];
  return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBAppCall handleDidBecomeActive];
}

@end
