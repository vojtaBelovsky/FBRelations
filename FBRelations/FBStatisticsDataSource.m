//
//  FBStatisticsDataSource.m
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsDataSource.h"
#import "FBStatisticsCell.h"
#import "FBUser.h"

@implementation FBStatisticsDataSource

#pragma mark - LifeCycles

- (id)init {
  self = [super init];
  if ( self ) {
    _items = [@[] mutableCopy];
  }
  
  return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FBUser *user = _items[ indexPath.row ] ;
  FBStatisticsCell *cell = [FBStatisticsCell createCellWithTableView:tableView];
  [cell setUser:user];
  
  return cell;
}


@end
