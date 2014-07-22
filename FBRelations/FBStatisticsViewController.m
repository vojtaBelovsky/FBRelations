//
//  FBStatisticsViewController.m
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsViewController.h"
#import "FBStatisticsDataSource.h"
#import "FBUserDetailViewController.h"
#import "FBBeaconManager.h"
#import "FBUser.h"
#import "FBAPI.h"
#import <CoreLocation/CLGeocoder.h>
#import "FBUserDetailViewController.h"
#import "Meeting.h"
#import <CoreLocation/CoreLocation.h>

static CGFloat rowHeight = 60.0f;

@interface FBStatisticsViewController () {
  FBStatisticsDataSource *_dataSource;
}

@end

@implementation FBStatisticsViewController

#pragma mark - LifeCycles

- (id)init {
  self = [super init];
  if ( self ) {
    _dataSource = [[FBStatisticsDataSource alloc] init];
  }
  
  return self;
}

- (void)loadView {
  [super loadView];
  
  self.tableView.dataSource = _dataSource;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  FBUser *user = _dataSource.items[ indexPath.row ];
  FBUserDetailViewController *userDetailViewController = [[FBUserDetailViewController alloc] initWithUserId:user.userId];
  [self.navigationController pushViewController:userDetailViewController animated:YES];
}

#pragma mark - Public

- (BOOL)containsUserWithMinor:(NSNumber *)minor major:(NSNumber *)major {
  NSDictionary *dict = @{ @"minor" : minor, @"major" : major };
  if ( ![_dataSource.fbIds containsObject:dict] ) {
    [_dataSource.fbIds addObject:dict];
    
    return NO;
  }
  
  return YES;
}

- (void)addNewUserWithFacebookId:(NSString *)facebookId withLocation:(CLLocation *)location {
  [FBAPI loadUserInfoWithId:facebookId completetionBlock:^( FBUser *user ) {
    [_dataSource.items addObject:user];
    [self.tableView reloadData];
  } failureBlock:^(NSError *error) {
    
  }];
  
  [Meeting getActualAddressFromLocation:location WithSuccess:^( Meeting *address ) {
    
  } failure:^( NSError *error ) {
    
  }];
}

@end
