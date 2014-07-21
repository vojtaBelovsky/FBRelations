//
//  FBAddress.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 21/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface FBAddress : NSObject

typedef void(^FBAddressCompletitionBlock)( FBAddress *address );
typedef void(^FBAddressFailureBlock)( NSError *error );

@property NSString *state;
@property NSString *city;
@property NSString *street;
@property NSString *ZipCode;
@property NSString *country;

+ (void)getActualAddressFromLocation:(CLLocation *)location WithSuccess:(FBAddressCompletitionBlock)completetionBlock failure:(FBAddressFailureBlock)failureBlock;

@end
