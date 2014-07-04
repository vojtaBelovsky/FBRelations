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

static NSString *BeaconIdentifier = @"beaconIdentifier";

@interface FBBeaconManager () {
  CLBeaconRegion *_region;
  CBPeripheralManager *_peripheralManager;
}

@end
@implementation FBBeaconManager

#pragma mark - LifeCycles

+ (FBBeaconManager *)sharedInstance {
  static FBBeaconManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[FBBeaconManager alloc] init];
    [sharedInstance initializeBeacon];
  });
  
  return sharedInstance;
}

#pragma mark - Public

- (void)setUser:(FBUser *)user {
  NSMutableDictionary *peripheralData = nil;
  CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID major:[@( 0 ) shortValue] minor:[@( 0 ) shortValue] identifier:BeaconIdentifier];
  
  NSDictionary *measuredPeripheralData = [region peripheralDataWithMeasuredPower:BEACON_POWER];
  peripheralData = [NSMutableDictionary dictionaryWithDictionary:measuredPeripheralData];
  peripheralData[ @"user" ] = user;
  
  if( peripheralData ) {
    [_peripheralManager startAdvertising:peripheralData];
  }
}

#pragma mark - Private

- (void)initializeBeacon {
  _locationManager = [[CLLocationManager alloc] init];
  _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
  _region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID major:[@( 0 ) shortValue] minor:[@( 0 ) shortValue] identifier:BeaconIdentifier];
  
  [_locationManager startRangingBeaconsInRegion:_region];
}

@end
