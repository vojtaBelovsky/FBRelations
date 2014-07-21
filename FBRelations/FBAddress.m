//
//  FBAddress.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 21/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBAddress.h"
#import <CoreLocation/CoreLocation.h>
#import "FBBeaconManager.h"
#import <AddressBook/ABPerson.h>

@implementation FBAddress

+ (void)getActualAddressFromLocation:(CLLocation *)location WithSuccess:(FBAddressCompletitionBlock)completetionBlock failure:(FBAddressFailureBlock)failureBlock {
  
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
   {
     if (!(error))
     {
       FBAddress *actualAddress = [[FBAddress alloc] init];
       CLPlacemark *placemark = [placemarks objectAtIndex:0];
       NSDictionary *addressDictionary = placemark.addressDictionary;
       actualAddress.state = addressDictionary[(NSString *)kABPersonAddressStateKey];
       actualAddress.city = addressDictionary[(NSString *)kABPersonAddressCityKey];
       actualAddress.street = addressDictionary[(NSString *)kABPersonAddressStreetKey];
       actualAddress.ZipCode = addressDictionary[(NSString *)kABPersonAddressZIPKey];
       actualAddress.country = addressDictionary[(NSString *)kABPersonAddressCountryKey];
       
       dispatch_async(dispatch_get_main_queue(), ^{
         DK_CALL_BLOCK( completetionBlock, actualAddress );
       });
     }
     else
     {
       NSLog(@"Geocode failed with error %@", error);
       NSLog(@"\nCurrent Location Not Detected\n");
       dispatch_async(dispatch_get_main_queue(), ^{
         DK_CALL_BLOCK( failureBlock, nil );
       });
     }
   }];
}

@end
