//
//  FBBook.m
//  FBRelations
//
//  Created by Daniel Krezelok on 04/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBBook.h"

@implementation FBBook

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"createdTime" : @"created_time",
            @"bookId" : @"id"
            };
}

@end
