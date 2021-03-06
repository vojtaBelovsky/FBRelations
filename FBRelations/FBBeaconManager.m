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

- (void)setBeaconWithMinor:(NSNumber *)minor major:(NSNumber *)major {
  CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID major:major.unsignedIntValue minor:minor.unsignedIntValue identifier:kBeaconIdentifier];
  
  NSDictionary *measuredPeripheralData = [region peripheralDataWithMeasuredPower:BEACON_POWER];
  
  if( measuredPeripheralData ) {
    _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:nil queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [_peripheralManager startAdvertising:measuredPeripheralData];
  }
}

#pragma mark - Private

- (void)initializeLocationManager {
  _locationManager = [[CLLocationManager alloc] init];
  _region = [[CLBeaconRegion alloc] initWithProximityUUID:BEACON_UUID identifier:kBeaconIdentifier];
  
  [_locationManager startRangingBeaconsInRegion:_region];
}

@end
