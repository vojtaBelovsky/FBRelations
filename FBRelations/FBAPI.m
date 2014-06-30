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

#define GET_METHOD @"GET"

#define FRIENDS    @"friends"
#define ME         @"me"

@implementation FBAPI

#pragma mark - Class

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
    NSString *grapthPath = [NSString stringWithFormat:@"/%@", userId];
    NSLog( @"userInfo" );    
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
    NSLog( @"open or extended" );
    // Close the session and remove the access token from the cache
    // The session state handler (in the app delegate) will be called automatically
    [FBSession.activeSession closeAndClearTokenInformation];
    // If the session state is not any of the two "open" states when the button is clicked
  } /*else if ( state == FBSessionStateCreatedTokenLoaded ){
    NSLog( @"loaded" );
    DK_CALL_BLOCK( completetionBlock );
  } */else {
    NSLog( @"open session" );
    // Open a session showing the user the login UI
    // You must ALWAYS ask for public_profile permissions when opening a session
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"user_friends"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^( FBSession *session, FBSessionState state, NSError *error ) {
       if ( error ) {
         DK_CALL_BLOCK( failureBlock, error );
       } else {
         DK_CALL_BLOCK( completetionBlock );
       }
     }];
  }
}

@end
