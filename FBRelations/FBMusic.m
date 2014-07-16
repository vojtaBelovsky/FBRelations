//
//  FBMusic.m
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBMusic.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FBMusic

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"createdTime" : @"created_time",
            @"musicId" : @"id",
            @"picture" : @"picture.data.url"
            };
}

#pragma mark - Class

+ (NSArray *)populateMusic:(NSArray *)array {
  FBMusic *music;
  NSError *error;
  NSMutableArray *musics = [@[] mutableCopy];
  for ( FBGraphObject *graphObject in array ) {
    music = [MTLJSONAdapter modelOfClass:[FBMusic class]
                      fromJSONDictionary:graphObject
                                   error:&error];
    [musics addObject:music];
  }
  
  return musics;
}

#pragma mark - Overriden

- (NSString *)originalPictureGraphPathWithId:(NSString *)pictureId {
  NSString *graphPath = [NSString stringWithFormat:@"/%@?fields=picture.type(large),name", pictureId];
  
  return graphPath;
}

- (NSString *)originalPictureUrlFromDict:(NSDictionary *)dict {
  NSString *url = dict[ @"picture" ][ @"data" ][ @"url" ];
  
  return url;
}

- (NSString *)pictureId {
  return _musicId;
}

- (FBEntityType)entityType {
  return FBEntityTypeMusic;
}

@end
