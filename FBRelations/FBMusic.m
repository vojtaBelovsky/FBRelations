//
//  FBMusic.m
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBMusic.h"

@implementation FBMusic

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"createdTime" : @"created_time",
            @"musicId" : @"id",
            @"picture" : @"cover.source"
            };
}

@end
