//
//  FBPhoto.m
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBPhoto.h"
#import "FBUser.h"

@implementation FBPhoto

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"createdTime" : @"created_time",
            @"updatedTime" : @"updated_time",
            @"photoId" : @"id"
            };
}

#pragma mark - NSValueTransformer

+ (NSValueTransformer *)fromJSONTransformer {
  return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FBUser class]];
}

#pragma mark - Properties

- (NSString *)pictureId {
  return _photoId;
}

@end
