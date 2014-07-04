//
//  FBBeaconManager.h
//  FBRelations
//
//  Created by Daniel Krezelok on 04/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBUser;
@class CLLocationManager;

#define BEACON_UUID   [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"]
#define BEACON_POWER  @( -59 )

@interface FBBeaconManager : NSObject
+ (FBBeaconManager *)sharedInstance;
- (void)setUser:(FBUser *)user;
@property (readonly) CLLocationManager *locationManager;
@end
