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

#define GET_METHOD @"GET"

#define FRIENDS    @"friends"
#define ALBUMS     @"albums"
#define MUSIC      @"music"
#define MOVIES     @"movies"
#define PHOTOS     @"photos"
#define PICTURE    @"picture"

#define ME         @"me"

@implementation FBAPI

#pragma mark - Class

+ (void)loadMoviesWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@", userId, MOVIES];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      FBMovie *movie;
      NSError *error;
      NSArray *array = data[ @"data" ];
      NSMutableArray *movies = [@[] mutableCopy];
      for ( FBGraphObject *graphObject in array ) {
        movie = [MTLJSONAdapter modelOfClass:[FBMovie class]
                               fromJSONDictionary:graphObject
                                            error:&error];
        [movies addObject:movie];
      }
      
      DK_CALL_BLOCK( completetionBlock, movies );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadMusicWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@?fields=category,created_time,name,cover", userId, MUSIC];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      FBMusic *musicAlbum;
      NSError *error;
      NSArray *array = data[ @"data" ];
      NSMutableArray *albums = [@[] mutableCopy];
      for ( FBGraphObject *graphObject in array ) {
        musicAlbum = [MTLJSONAdapter modelOfClass:[FBMusic class]
                          fromJSONDictionary:graphObject
                                       error:&error];
        [albums addObject:musicAlbum];
      }
      
      DK_CALL_BLOCK( completetionBlock, albums );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadPhotosWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBAPI authenticateIfNeededWithCompletetionBlock:^{
    NSString *grapthPath = [NSString stringWithFormat:@"/%@/%@", userId, PHOTOS];
    [FBAPI callGrapthPath:grapthPath params:nil method:GET_METHOD completetionBlock:^( id data ) {
      FBPhoto *photo;
      NSError *error;
      NSArray *array = data[ @"data" ];
      NSMutableArray *photos = [@[] mutableCopy];
      for ( FBGraphObject *graphObject in array ) {
        photo = [MTLJSONAdapter modelOfClass:[FBPhoto class]
                          fromJSONDictionary:graphObject
                                       error:&error];
        [photos addObject:photo];
      }
      
      DK_CALL_BLOCK( completetionBlock, photos );
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
      
      DK_CALL_BLOCK( completetionBlock, albums );
    } failureBlock:failureBlock];
  } failureBlock:failureBlock];
}

+ (void)loadMyFriendsWithCompletetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
    [FBAPI loadFriendsWithUserId:ME completetionBlock:completetionBlock failureBlock:failureBlock];
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
    NSString *grapthPath = [NSString stringWithFormat:@"/%@?fields=picture,cover,first_name,name,gender,last_name,link,locale,timezone,updated_time,verified,hometown,location,relationship_status,birthday", userId];
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

+ (void)callGrapthPath:(NSString *)grapthPath params:(NSDictionary *)params method:(NSString *)method completetionBlock:(FBCompletetionBlockResultData)completetionBlock failureBlock:(FBFailureBlock)failureBlock {
  [FBRequestConnection startWithGraphPath:grapthPath
                               parameters:params
                               HTTPMethod:method
                        completionHandler:^(
                                            FBRequestConnection *connection,
                                            id result,
                                            NSError *error
                                            ) {
                          if ( error ) {
                            DK_CALL_BLOCK( failureBlock, error );
                          } else {
                            DK_CALL_BLOCK( completetionBlock, result );
                          }
                        }];
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
         DK_CALL_BLOCK( completetionBlock );
       } else {
         DK_CALL_BLOCK( failureBlock, error );
       }
     }];
  }
}

+ (BOOL)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error  {
  // If the session was opened successfully
  if ( !error && state == FBSessionStateOpen ){
    NSLog(@"Session opened");
    // Show the user the logged-in UI
    return YES;
  }
  
  // Handle errors
  if ( error ) {
    NSLog( @"%@", error );

    [FBSession.activeSession closeAndClearTokenInformation];
  }
  
  return NO;
}

@end
