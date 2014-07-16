//
//  FBStatisticsTableViewCell.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 14/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsDetailTableViewCell.h"

#define FBStatisticDetailDataSourceReuseIdentifier  @"FBStatisticDetailDataSourceReuseIdentifier"

@interface FBStatisticsDetailTableViewCell (){
  UILabel *_time;
  UILabel *_city;
  UILabel *_address;
}

@end

@implementation FBStatisticsDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+(FBStatisticsDetailTableViewCell*)createUserTableViewCellWithTableView:(UITableView *)tableView {
  FBStatisticsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FBStatisticDetailDataSourceReuseIdentifier];
  if ( !cell ) {
    cell = [[FBStatisticsDetailTableViewCell alloc] init];
  }
  return cell;
}

@end
