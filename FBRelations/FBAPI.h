//
//  FBAPI.h
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBSession.h"

typedef NS_ENUM( NSUInteger, FBEntityType ) {
  FBEntityTypeFriends,
  FBEntityTypeMovies,
  FBEntityTypeMusic,
  FBEntityTypePhotos,
  FBEntityTypeBooks
};

@class FBUser;

@interface FBAPI : NSObject

typedef void(^FBUserInfoCompletetionBlock)( FBUser *user );
typedef void(^FBCompletetionBlockResultArray)( NSArray *data, NSString *nextPageUrl );
typedef void(^FBCompletetionBlockResultData)( id data );
typedef void(^FBCompletetionBlock)(  );
typedef void(^FBFailureBlock)( NSError *error );

+ (BOOL)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

+ (void)loadWithPageUrl:(NSString *)pageUrl type:(FBEntityType)type completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;

+ (void)loadBooksWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;
+ (void)loadPhotosWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;

+ (void)loadMoviesWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;

+ (void)loadMusicWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;

+ (void)loadAlbumsWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;

+ (void)loadUserInfoWithId:(NSString *)userId completetionBlock:(FBUserInfoCompletetionBlock)completetionBlock failureBlock:(FBFailureBlock)failureBlock;

+ (void)loadFriendsWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;
@end
