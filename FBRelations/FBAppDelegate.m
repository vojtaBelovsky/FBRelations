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

@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
     
     // Retrieve the app delegate
//     AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
     // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
     [FBAPI sessionStateChanged:session state:state error:error];
   }];
  return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}
//  // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
//  BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
//  
//  // You can add your app-specific url handling code here if needed
//  
//  return wasHandled;
//}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBAppCall handleDidBecomeActive];
}

@end
