//
//  ServerHTTPSessionManager.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "ServerHTTPSessionManager.h"
#import <AFHTTPRequestOperationManager.h>

#define POST_URL @"http://alijen.cz/fbrelations/pridejid.php"
#define GET_URL @"http://alijen.cz/fbrelations/getid.php"

@implementation ServerHTTPSessionManager

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
