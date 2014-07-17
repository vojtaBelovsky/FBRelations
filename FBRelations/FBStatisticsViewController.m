//
//  FBStatisticsViewController.m
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsViewController.h"
#import "FBStatisticsDataSource.h"
#import "FBUser.h"
#import "FBAPI.h"
#import "FBUserDetailViewController.h"

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

- (void)addNewUserWithFacebookId:(NSString *)facebookId {
  if ( [_dataSource.fbIds containsObject:facebookId] ) {
    return;
  }
  
  [_dataSource.fbIds addObject:facebookId];
  [FBAPI loadUserInfoWithId:facebookId completetionBlock:^( FBUser *user ) {
    [_dataSource.items addObject:user];
    [self.tableView reloadData];
  } failureBlock:^(NSError *error) {
    
  }];
}

@end
