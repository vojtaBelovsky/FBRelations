//
//  FBStatisticsCell.h
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBUser;

@interface FBStatisticsCell : UITableViewCell
+ (FBStatisticsCell *)createCellWithTableView:(UITableView *)tableView;
- (void)setUser:(FBUser *)user;
@end
