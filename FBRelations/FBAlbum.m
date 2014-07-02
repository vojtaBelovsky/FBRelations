//
//  FBAlbum.m
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBAlbum.h"
#import "FBUser.h"

@implementation FBAlbum

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"canUpload" : @"can_upload",
            @"coverPhoto" : @"cover_photo",
            @"createdTime" : @"created_time",
            @"albumId" : @"id",
            @"updatedTime" : @"updated_time",
            @"from" : @"from"         
            };
}

#pragma mark - NSValueTransformer

+ (NSValueTransformer *)fromJSONTransformer {
  return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[FBUser class]];
}

@end
