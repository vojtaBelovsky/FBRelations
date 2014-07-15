//
//  FBStatisticsTableViewCell.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 14/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsTableViewCell.h"

#define FBStatisticDataSourceReuseIdentifier  @"FBStatisticDataSourceReuseIdentifier"

@interface FBStatisticsTableViewCell (){
  UILabel *_time;
  UILabel *_city;
  UILabel *_address;
}

@end

@implementation FBStatisticsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+(FBStatisticsTableViewCell*)createUserTableViewCellWithTableView:(UITableView *)tableView {
  FBStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FBStatisticDataSourceReuseIdentifier];
  if ( !cell ) {
    cell = [[FBStatisticsTableViewCell alloc] init];
  }
  return cell;
}

@end
