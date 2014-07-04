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

static NSString *BeaconIdentifier = @"a";

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
  CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID major:user.userId.hash minor:0
                                                              identifier:BeaconIdentifier];
  NSDictionary *measuredPeripheralData = [region peripheralDataWithMeasuredPower:BEACON_POWER];
  peripheralData = [NSMutableDictionary dictionaryWithDictionary:measuredPeripheralData];
  peripheralData[ CBAdvertisementDataLocalNameKey ] = user.name;
  
  if( peripheralData ) {
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

    [_peripheralManager startAdvertising:peripheralData];
  }
}

#pragma mark - Private

- (void)initializeLocationManager {
  _locationManager = [[CLLocationManager alloc] init];
  _region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID identifier:BeaconIdentifier];
  [_locationManager startRangingBeaconsInRegion:_region];
}

@end
