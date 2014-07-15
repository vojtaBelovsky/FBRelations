//
//  ServerHTTPSessionManager.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "ServerHTTPSessionManager.h"
#import <AFHTTPRequestOperationManager.h>

#define NOVY_SERVER @"http://fbrelationsapi.ic.cz/index.php"

#define POST_URL @"http://alijen.cz/fbrelations/pridejid.php"
#define GET_URL @"http://alijen.cz/fbrelations/getid.php"

@implementation ServerHTTPSessionManager

+(void)POSTFBID:(NSString*)FB_ID success:(ServerPOSTCompletetionBlockResultData)success failure:(ServerFailureBlock)failure{
  
  NSDictionary *params = @{ @"FB_ID" : FB_ID };
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager POST:NOVY_SERVER parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( success, responseObject );
    });
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( failure, error );
    });
  }];
}

+(void)GETFBIDWithMinor:(NSNumber *)minor andMajor:(NSNumber *)major success:(ServerGETCompletetionBlockResultData)success failure:(ServerFailureBlock)failure{
  
  NSDictionary *params = @{ @"minor" : minor, @"major" : major };
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  [manager GET:NOVY_SERVER parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    id obj = [responseObject objectForKey:@"FB_ID"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( success,  obj);
    });
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( failure, error );
    });
  }];
}

+(void)GETDataForParameter:(NSString*)userId success:(ServerGETCompletetionBlockResultData)success failure:(ServerFailureBlock)failure{
  
  NSDictionary *params = @{ @"beacon_id" : userId };
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFJSONResponseSerializer serializer];
  [manager GET:GET_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( success, nil );
    });
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( failure, error );
    });
  }];
}

+(void)POSTDataUserId:(NSString*)userId andFBID:(NSString *)FBID success:(ServerPOSTCompletetionBlockResultData)success failure:(ServerFailureBlock)failure{
  
  NSDictionary *params = @{ @"beacon_id" : userId , @"fb_id" : FBID};
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager POST:POST_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( success, nil );
    });
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      DK_CALL_BLOCK( failure, error );
    });
  }];
}


@end
