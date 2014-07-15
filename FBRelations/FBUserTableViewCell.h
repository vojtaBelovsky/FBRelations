//
//  FBUserTableViewCell.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 14/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  CTGreen,
  CTOrange,
  CTRed
} ColorType;

@interface FBUserTableViewCell : UITableViewCell

-(void)setAvatarWithUrl:(NSString *)url;
-(void)setMeetingNumberCircleImageColor:(ColorType)color;
+(FBUserTableViewCell*)createUserTableViewCellWithTableView:(UITableView *)tableView;

@end
