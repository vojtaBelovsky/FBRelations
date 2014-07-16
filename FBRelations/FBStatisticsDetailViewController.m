//
//  FBStatisticsViewController.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsDetailViewController.h"
#import "FBUser.h"
#import "FBStatisticsDetailDataSource.h"
#import "FBAppDelegate.h"

@interface FBStatisticsDetailViewController () {
  FBUser *_user;
  FBStatisticsDetailDataSource *_dataSource;
}

@end

@implementation FBStatisticsDetailViewController

- (id)initWithUserId:(NSString *)userId {
  self = [super init];
  if ( self ) {
    self.title = NSLocalizedString( @"FBRelations", @"" );
    _user = [[FBUser alloc] initWithUserId:userId];
    _dataSource = [[FBStatisticsDetailDataSource alloc] init];
  }
  
  return self;
}

-(void)initializeData{
  
}

@end
