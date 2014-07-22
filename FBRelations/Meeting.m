//
//  Meeting.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 21/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "Meeting.h"
#import <CoreLocation/CoreLocation.h>
#import "FBBeaconManager.h"
#import <AddressBook/AddressBook.h>
#import <MagicalRecord/MagicalRecord.h>

@implementation Meeting

@dynamic date;
@dynamic userId;
@dynamic state;
@dynamic country;
@dynamic city;
@dynamic street;
@dynamic zipCode;

+ (void)getActualAddressFromLocation:(CLLocation *)location WithSuccess:(MeetingCompletitionBlock)completetionBlock failure:(MeetingFailureBlock)failureBlock {
  
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
   {
     if (!(error))
     {
       Meeting *newMeeting = [[Meeting alloc] init];
       CLPlacemark *placemark = [placemarks objectAtIndex:0];
       NSDictionary *addressDictionary = placemark.addressDictionary;
       newMeeting.state = addressDictionary[(NSString *)kABPersonAddressStateKey];
       newMeeting.city = addressDictionary[(NSString *)kABPersonAddressCityKey];
       newMeeting.street = addressDictionary[(NSString *)kABPersonAddressStreetKey];
       newMeeting.ZipCode = addressDictionary[(NSString *)kABPersonAddressZIPKey];
       newMeeting.country = addressDictionary[(NSString *)kABPersonAddressCountryKey];
       
       dispatch_async(dispatch_get_main_queue(), ^{
         DK_CALL_BLOCK( completetionBlock, newMeeting );
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
