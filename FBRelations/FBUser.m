//
//  FBUser.m
//  FBRelations
//
//  Created by Daniel Krezelok on 30/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUser.h"

@implementation FBUser

#pragma mark - LifeCycles

- (id)initWithUserId:(NSString *)userId {
  self = [super init];
  if ( self ) {
    _userId = userId;
  }
  
  return self;
}

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"firstName" : @"first_name",
            @"userId" : @"id",
            @"lastName" : @"last_name",
            @"locale" : @"last_name",
            @"updateTime" : @"updated_time",
            @"picture" : @"picture.data.url",
            @"cover" : @"cover.source"
            };
}

@end
