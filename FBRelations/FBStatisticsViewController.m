//
//  FBStatisticsViewController.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsViewController.h"
#import "FBUser.h"
#import "FBStatisticDataSource.h"
#import "FBAppDelegate.h"

@interface FBStatisticsViewController () {
  FBUser *_user;
  FBStatisticDataSource *_dataSource;
}

@end

@implementation FBStatisticsViewController

- (id)initWithUserId:(NSString *)userId {
  self = [super init];
  if ( self ) {
    self.title = NSLocalizedString( @"FBRelations", @"" );
    _user = [[FBUser alloc] initWithUserId:userId];
    _dataSource = [[FBStatisticDataSource alloc] init];
  }
  
  return self;
}

-(void)initializeData{
  
}

@end
