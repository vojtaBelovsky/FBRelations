//
//  FBAppDelegate.m
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBAppDelegate.h"
#import "FBStatisticsViewController.h"
#import "FBAPI.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBBeaconManager.h"
#import "FBUser.h"
#import "ServerHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

#define ME @"me"

@interface FBAppDelegate () {
  FBStatisticsViewController *_statisticsViewController;
}

@end
@implementation FBAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  _statisticsViewController = [[FBStatisticsViewController alloc] init];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_statisticsViewController];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = navigationController;
  self.window.backgroundColor = WHITE_COLOR;
  [self.window makeKeyAndVisible];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentUserDidLoadNotification) name:kCurrentUserDidLoadNotification object:nil];
  

  [self performSelector:@selector(initializeMe) withObject:self afterDelay:3];
  [FBBeaconManager sharedInstance];
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  [FBSession.activeSession setStateChangeHandler:
   ^(FBSession *session, FBSessionState state, NSError *error) {
     if ( state == FBSessionStateOpen ) {
       [self initializeMe];
     }
   }];
  return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBAppCall handleDidBecomeActive];
}

#pragma mark - Memory Management

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)currentUserDidLoadNotification {
  [ServerHTTPSessionManager POSTFBID:_user.userId success:^( id data ) {
    NSNumber *minor = data [@"minor"];
    NSNumber *major = data [@"major"];
    [FBBeaconManager sharedInstance].locationManager.delegate = self;
    [[FBBeaconManager sharedInstance] setBeaconWithMinor:minor major:major];
  } failure:^(NSError *error) {
    
  }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
  for ( CLBeacon *beacon in beacons ) {
    NSLog( @"beacon: %@", beacon );
    if ( ![_statisticsViewController containsUserWithMinor:beacon.minor major:beacon.major] ) {
      [ServerHTTPSessionManager GETFBIDWithMinor:beacon.minor andMajor:beacon.major success:^(id data) {
        NSString *facebookID = data;
        CLLocation *actualLocation = [[[FBBeaconManager sharedInstance] locationManager] location];
        [_statisticsViewController addNewUserWithFacebookId:facebookID withLocation:actualLocation];
      } failure:^(NSError *error) {
        
      }];
    }
  }
}


#pragma mark - Private

- (void)initializeMe {
  [FBAPI loadUserInfoWithId:ME completetionBlock:^( FBUser *user ) {
    _user = user;
    [self currentUserDidLoadNotification];
  } failureBlock:^( NSError *error ) {
    NSLog( @"%@", error );
  }];
}

@end
