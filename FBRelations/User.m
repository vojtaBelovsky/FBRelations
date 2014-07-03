//
//  User.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "User.h"
#import "FBUser.h"
#import <CoreData+MagicalRecord.h>
#import <UIImageView+AFNetworking.h>

@implementation User

@dynamic firstName;
@dynamic lastName;
@dynamic gender;
@dynamic userId;
@dynamic link;
@dynamic lastUpdated;
@dynamic locale;
@dynamic name;
@dynamic timezone;
@dynamic updateTime;
@dynamic verified;
@dynamic picture;
@dynamic cover;
@dynamic birthday;
@dynamic relationStatus;
@dynamic coverImage;
@dynamic pictureImage;

+(void)saveUserWithFBUser:(FBUser*) user{
  
  NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId ==[c] %@", user.userId];
  
  User *userFounded = [User MR_findFirstWithPredicate:predicate inContext:localContext];
  
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"MM/dd/yyyy"];
  
  if ( userFounded) {
    
    NSDate *lastUpdated = [df dateFromString:userFounded.lastUpdated];
    NSDate *now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:lastUpdated
                                       toDate:now
                                       options:0];
    NSInteger days = [ageComponents day];
    
    if ( days >= 1) {
      [self fillUser:userFounded WithFBUser:user inContext:localContext withDateFormatter:df];
      
      [localContext MR_saveToPersistentStoreAndWait];
    }
  } else {
    User * newUser = [User MR_createInContext:localContext];
    [self fillUser:newUser WithFBUser:user inContext:localContext withDateFormatter:df];
    
    [localContext MR_saveToPersistentStoreAndWait];
  }
}

+(void)fillUser:(User *)newUser WithFBUser:(FBUser *)user inContext:(NSManagedObjectContext *)localContext withDateFormatter:(NSDateFormatter *)df {
  newUser.firstName = user.firstName;
  newUser.lastName = user.lastName;
  newUser.gender = user.gender;
  newUser.userId = user.userId;
  newUser.link = user.link;
  newUser.lastUpdated = [df stringFromDate:[NSDate date]];
  newUser.locale = user.locale;
  newUser.name = user.name;
  newUser.timezone = user.timezone;
  newUser.updateTime = user.updateTime;
  newUser.verified = user.verified;
  newUser.picture = user.picture;
  newUser.cover = user.cover;
  newUser.birthday = user.birthday;
  newUser.relationStatus = user.relationStatus;
}

+(void)savePicture:(UIImage *)picture forUser:(FBUser *)user {
  NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId ==[c] %@", user.userId];
  
  User *userFounded = [User MR_findFirstWithPredicate:predicate inContext:localContext];
  
  if ( userFounded ) {
    NSData * pictureAsData = UIImagePNGRepresentation(picture);
    
    if ( pictureAsData != nil ) {
      userFounded.pictureImage = pictureAsData;
    }
  }
}

+(void)saveCover:(UIImage *)cover forUser:(FBUser *)user {
  NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId ==[c] %@", user.userId];
  
  User *userFounded = [User MR_findFirstWithPredicate:predicate inContext:localContext];
  
  if ( userFounded ) {
    NSData * coverAsData = UIImagePNGRepresentation(cover);
    
    if ( coverAsData != nil ) {
      userFounded.coverImage = coverAsData;
    }
  }
}


@end
