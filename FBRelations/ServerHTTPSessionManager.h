//
//  ServerHTTPSessionManager.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface ServerHTTPSessionManager : AFHTTPSessionManager

typedef void(^ServerGETCompletetionBlockResultData)( id data );
typedef void(^ServerPOSTCompletetionBlockResultData)( id data );
typedef void(^ServerFailureBlock)( NSError *error );

+(void)GETDataForParameter:(NSString*)userId success:(ServerGETCompletetionBlockResultData)success failure:(ServerFailureBlock)failure;

+(void)POSTDataUserId:(NSString*)userId andFBID:(NSString *)FBID success:(ServerPOSTCompletetionBlockResultData)success failure:(ServerFailureBlock)failure;

@end
