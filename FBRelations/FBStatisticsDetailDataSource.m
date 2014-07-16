//
//  FBStatisticDataSource.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsDetailDataSource.h"
#import "FBStatisticsDetailTableViewCell.h"
#import "FBUserTableViewCell.h"
#import "FBUser.h"

@implementation FBStatisticsDetailDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if (section == 0) {
    return 1;
  } else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  if ( indexPath.section == 0 ) {
    FBUserTableViewCell *cell = [FBUserTableViewCell createUserTableViewCellWithTableView:tableView];
    [cell setAvatarWithUrl:_user.picture];
    // Set here lastMetCircleColor
    return cell;
  } else {
    FBStatisticsDetailTableViewCell *cell = [FBStatisticsDetailTableViewCell createUserTableViewCellWithTableView:tableView];
    return cell;
  }
}
@end
