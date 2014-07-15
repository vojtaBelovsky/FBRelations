//
//  FBMovie.m
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBMovie.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FBMovie

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{ @"createdTime" : @"created_time",
            @"musicId" : @"id",
            @"picture" : @"picture.data.url"
            };
}

#pragma mark - Class

+ (NSArray *)populateMovies:(NSArray *)array {
  FBMovie *movie;
  NSError *error;
  NSMutableArray *movies = [@[] mutableCopy];
  for ( FBGraphObject *graphObject in array ) {
    movie = [MTLJSONAdapter modelOfClass:[FBMovie class]
                      fromJSONDictionary:graphObject
                                   error:&error];
    [movies addObject:movie];
  }
  
  return movies;
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
  return FBEntityTypeMovies;
}

@end
