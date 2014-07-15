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

#import "ServerHTTPSessionManager.h"

@implementation FBAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [FBBeaconManager sharedInstance];
  FBUserDetailViewController *userDetailViewController = [[FBUserDetailViewController alloc] initWithUserId:@"me"];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userDetailViewController];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = navigationController;
  self.window.backgroundColor = WHITE_COLOR;
  [self.window makeKeyAndVisible];

  [ServerHTTPSessionManager POSTFBID:@"2987451418934" success:^(id data) {
    int minor = [data objectForKey:@"minor"];
    int major = [data objectForKey:@"major"];
  } failure:^(NSError *error) {
    
  }];
  
  [ServerHTTPSessionManager GETFBIDWithMinor:[NSNumber numberWithInt:0] andMajor:[NSNumber numberWithInt:0] success:^(id data) {
    NSString *FB_ID = data;
  } failure:^(NSError *error) {
    
  }];
  
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
