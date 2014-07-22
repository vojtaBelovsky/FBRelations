//
//  Meeting.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 21/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class CLLocation;

@interface Meeting : NSManagedObject

typedef void(^MeetingCompletitionBlock)( Meeting *meeting );
typedef void(^MeetingFailureBlock)( NSError *error );

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * zipCode;

+ (void)getActualAddressFromLocation:(CLLocation *)location WithSuccess:(MeetingCompletitionBlock)completetionBlock failure:(MeetingFailureBlock)failureBlock;

@end
