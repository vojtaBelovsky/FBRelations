//
//  FBAPI.h
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBUser;

@interface FBAPI : NSObject

typedef void(^FBUserInfoCompletetionBlock)( FBUser *user );
typedef void(^FBCompletetionBlockResultArray)( NSArray *data );
typedef void(^FBCompletetionBlockResultData)( id data );
typedef void(^FBCompletetionBlock)(  );
typedef void(^FBFailureBlock)( NSError *error );

+ (void)loadAlbumsWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;
+ (void)loadUserInfoWithId:(NSString *)userId completetionBlock:(FBUserInfoCompletetionBlock)completetionBlock failureBlock:(FBFailureBlock)failureBlock;
+ (void)loadMyFriendsWithCompletetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;
+ (void)loadFriendsWithUserId:(NSString *)userId completetionBlock:(FBCompletetionBlockResultArray)completetionBlock failureBlock:(FBFailureBlock)failureBlock;
@end
