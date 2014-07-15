//
//  FBAPI.m
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBAPI.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBAppDelegate.h"
#import "FBUser.h"
#import "FBAlbum.h"
#import "FBMusic.h"
#import "FBMovie.h"
#import "FBPhoto.h"
#import <AFNetworking/AFNetworking.h>

#define GET_METHOD @"GET"

#define FRIENDS    @"friends"
#define ALBUMS     @"albums"
#define MUSIC      @"music"
#define MOVIES     @"movies"
#define PHOTOS     @"photos"
#define PICTURE    @"picture"
#define BOOKS      @"books"

#define ME         @"me"

@implementation FBAPI

#pragma mark - Class

+ (void)loadWithPageUrl:(NSString *)pageUrl type:(FBEntityType)type completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI callUrl:pageUrl completetionBlock:^( id data ) {
    NSArray *array = data[ @"data" ];
    NSString *nextPageUrl = data[ @"paging" ][ @"next" ];

    NSArray *populateArray;
    switch ( type ) {
      case FBEntityTypeMovies:
        populateArray = [FBMovie populateMovies:array];
        break;
      case FBEntityTypeMusic:
        populateArray = [FBMusic populateMusic:array];
        break;
      case FBEntityTypePhotos:
        populateArray = [FBPhoto populatePhotos:array];
      default:
        break;
    }
    
    DK_CALL_BLOCK( completetionBlock, populateArray, nextPageUrl );
  } failureBlock:failureBlock];
}

+ (void)loadBooksWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@", userId, BOOKS];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      FBMovie *movie;
      NSError *error;
      NSArray *array = data[ @"data" ];
      NSMutableArray *books = [@[] mutableCopy];
      for ( FBGraphObject *graphObject in array ) {
        movie = [MTLJSONAdapter modelOfClass:[FBMovie class]
                          fromJSONDictionary:graphObject
                                       error:&error];
        [books addObject:movie];
      }
      
      DK_CALL_BLOCK( completetionBlock, books, nil );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadMoviesWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@?fields=category,created_time,name,picture.type(normal)", userId, MOVIES];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      NSArray *array = data[ @"data" ];
      NSString *nextPageUrl = data[ @"paging" ][ @"next" ];
      DK_CALL_BLOCK( completetionBlock, [FBMovie populateMovies:array], nextPageUrl );
    } failureBlock:failureBlock];
}

+ (void)loadMusicWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@?fields=category,created_time,name,picture.type(normal)", userId, MUSIC];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      NSArray *array = data[ @"data" ];
      NSString *nextPageUrl = data[ @"paging" ][ @"next" ];
      DK_CALL_BLOCK( completetionBlock, [FBMusic populateMusic:array], nextPageUrl );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadPhotosWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@", userId, PHOTOS];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      NSArray *array = data[ @"data" ];
      NSString *nextPageUrl = data[ @"paging" ][ @"next" ];
      DK_CALL_BLOCK( completetionBlock, [FBPhoto populatePhotos:array], nextPageUrl );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadAlbumsWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@", userId, ALBUMS];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      FBAlbum *album;
      NSError *error;
      NSArray *array = data[ @"data" ];
      NSMutableArray *albums = [@[] mutableCopy];
      for ( FBGraphObject *graphObject in array ) {
        album = [MTLJSONAdapter modelOfClass:[FBAlbum class]
                          fromJSONDictionary:graphObject
                                       error:&error];
        [albums addObject:album];
      }
      
      DK_CALL_BLOCK( completetionBlock, albums, nil );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadFriendsWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@", userId, FRIENDS];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}


+ (void)loadUserInfoWithId:(NSString *)userId completetionBlock:(FBUserInfoCompletetionBlock)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@?fields=picture.type(normal),cover,first_name,name,gender,last_name,link,locale,timezone,updated_time,verified,hometown,location,relationship_status,birthday", userId];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      NSDictionary *dict = data;
      NSError *error;
      FBUser *user = [MTLJSONAdapter modelOfClass:[FBUser class]
                               fromJSONDictionary:dict
                                            error:&error];
      DK_CALL_BLOCK( completetionBlock, user );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

#pragma mark - Private

+ (void)callUrl:(NSString *)url completetionBlock:(FBCompletetionBlockResultData)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      dispatch_async(dispatch_get_main_queue(), ^{
        DK_CALL_BLOCK( completetionBlock, responseObject );
      });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        DK_CALL_BLOCK( failureBlock, error );
      });
    }];
  } failureBlock:failureBlock];
}

+ (void)callGrapthPath:(NSString *)grapthPath params:(NSDictionary *)params method:(NSString *)method completetionBlock:(FBCompletetionBlockResultData)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    [FBRequestConnection startWithGraphPath:grapthPath
                                 parameters:params
                                 HTTPMethod:method
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                            if ( error ) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                DK_CALL_BLOCK( failureBlock, error );
                              });
                            } else {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                DK_CALL_BLOCK( completetionBlock, result );
                              });
                            }
                          }];
  } failureBlock:failureBlock];
}

+ (void)authenticateIfNeededWithCompletetionBlock:(FBCompletetionBlock)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  FBSessionState state = FBSession.activeSession.state;
  
  if ( state == FBSessionStateOpen || state == FBSessionStateOpenTokenExtended ) {
    DK_CALL_BLOCK( completetionBlock );
  } else {
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"user_friends", @"user_photos", @"user_likes", @"user_hometown", @"user_location", @"user_relationships", @"user_birthday"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^( FBSession *session, FBSessionState state, NSError *error ) {
       BOOL result = [FBAPI sessionStateChanged:session state:state error:error];
       if ( result ) {
         dispatch_async(dispatch_get_main_queue(), ^{
           DK_CALL_BLOCK( completetionBlock );
         });
       } else {
         dispatch_async(dispatch_get_main_queue(), ^{
           DK_CALL_BLOCK( failureBlock, error );
         });
       }
     }];
  }
}

+ (BOOL)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error  {
  // If the session was opened successfully
  if ( !error && state == FBSessionStateOpen ){
    NSLog(@"Session opened");
    return YES;
  }
  
  // Handle errors
  if ( error ) {
    NSLog( @"%@", error );
  }

  [FBSession.activeSession closeAndClearTokenInformation];
  return NO;
}

@end
