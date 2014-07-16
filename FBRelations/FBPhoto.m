//
//  FBPhoto.m
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBPhoto.h"
#import "FBUser.h"
#import <FacebookSDK/FacebookSDK.h>

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

#pragma mark - Class

+ (NSArray *)populatePhotos:(NSArray *)array {
  FBPhoto *photo;
  NSError *error;
  NSMutableArray *photos = [@[] mutableCopy];
  for ( FBGraphObject *graphObject in array ) {
    photo = [MTLJSONAdapter modelOfClass:[FBPhoto class]
                      fromJSONDictionary:graphObject
                                   error:&error];
    [photos addObject:photo];
  }
  
  return photos;
}

#pragma mark - Overriden

- (NSString *)originalPictureGraphPathWithId:(NSString *)pictureId {
  NSString *graphPath = [NSString stringWithFormat:@"/%@", pictureId];
  
  return graphPath;
}

- (NSString *)originalPictureUrlFromDict:(NSDictionary *)dict {
  NSString *url = dict[ @"source" ];
  
  return url;
}

- (NSString *)pictureId {
  return _photoId;
}

- (NSString *)name {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
  NSDate *date = [df dateFromString:self.createdTime];

  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
  
  NSString *dateStr = [NSString stringWithFormat:@"%d/%d/%d", components.day, components.month, components.year];
  NSString *formatted = [NSString stringWithFormat:@"Created by %@ - %@", self.from.name, dateStr];
  
  return formatted;
}

- (FBEntityType)entityType {
  return FBEntityTypePhotos;
}

@end
