//
//  FBBeaconManager.m
//  FBRelations
//
//  Created by Daniel Krezelok on 04/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBBeaconManager.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "FBUser.h"

#define BEACON_UUID_LENGHT 36
#define FIRST_DASH 8
#define SECOND_DASH 13
#define THIRD_DASH 18
#define FOURTH_DASH 23

static NSString *kBeaconIdentifier = @"kBeaconIdentifier";
CBPeripheralManager *_peripheralManager = nil;

@interface FBBeaconManager () {
  CLBeaconRegion *_region;
}

@end
@implementation FBBeaconManager

#pragma mark - LifeCycles

+ (FBBeaconManager *)sharedInstance {
  static FBBeaconManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[FBBeaconManager alloc] init];
    [sharedInstance initializeLocationManager];
  });
  
  return sharedInstance;
}

#pragma mark - Public

- (void)setUser:(FBUser *)user {
  NSMutableDictionary *peripheralData = nil;
  NSUUID *uuid =  [FBBeaconManager encodeFBUserID:user.userId];
  CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID major:0 minor:65535 identifier:kBeaconIdentifier];
  
  NSDictionary *measuredPeripheralData = [region peripheralDataWithMeasuredPower:BEACON_POWER];
  peripheralData = [NSMutableDictionary dictionaryWithDictionary:measuredPeripheralData];
  
  if( peripheralData ) {
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [_peripheralManager startAdvertising:peripheralData];
  }
}

#pragma mark - Private

- (void)initializeLocationManager {
  _locationManager = [[CLLocationManager alloc] init];
  _region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID identifier:kBeaconIdentifier];
  
  [_locationManager startRangingBeaconsInRegion:_region];
}

+ (NSUUID *)encodeFBUserID:(NSString *)userId {
  NSUInteger lenghtOfFBID = [userId length];
  NSInteger numberOfDashes = 0;
  NSMutableString *uuidInString = [[NSMutableString alloc] init];
  for ( NSUInteger i = 0; i < BEACON_UUID_LENGHT; i++) {
    if ( i == FIRST_DASH || i == SECOND_DASH || i == THIRD_DASH || i == FOURTH_DASH) {
      [uuidInString appendString:@"-"];
      numberOfDashes++;
      continue;
    }
    if (i < lenghtOfFBID+numberOfDashes) {
      [uuidInString appendString:[userId substringWithRange:NSMakeRange((i-numberOfDashes), 1)]];
    } else {
      [uuidInString appendString:@"A"];
    }
  }
  
  NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:uuidInString];
  return uuid;
}

+(NSString *)decodeBeaconUUID:(NSUUID *)BeaconUUID {
  NSMutableString *userId = [NSMutableString stringWithFormat:@"%@", BeaconUUID];
  [userId replaceOccurrencesOfString:@"-" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [userId length])];
  [userId replaceOccurrencesOfString:@"A" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [userId length])];
  
  return userId;
  
}

@end
