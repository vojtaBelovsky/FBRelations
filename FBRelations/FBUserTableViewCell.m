//
//  FBUserTableViewCell.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 14/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserTableViewCell.h"
#import <UIImageView+AFNetworking.h>

#define FBUserTableViewCellReuseIdentifier    @"FBUserTableViewCellReuseIdentifier"

#define NAME_FONT           [UIFont boldSystemFontOfSize:20.0f]
#define LAST_MET_FONT       [UIFont systemFontOfSize:16.0f]

#define ANIMATION_DURATION  0.2f

#define MASK                [UIImage imageNamed:@"mask"]
#define AVATAR_BACKGROUND   [UIImage imageNamed:@"avatarBackgroundShadowed"]
#define SEPARATOR           [UIImage imageNamed:@"line"]

@interface FBUserTableViewCell () {
  UIImageView *_avatarImageView;
  UIImageView *_separatorImageView;
  UIImageView *_meetingNumberCircle;
  
  UILabel *_nameLabel;
  UILabel *_lastMetLabel;
  UILabel *_numberOfMeetingLabel;
}

@end

@implementation FBUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

      _avatarImageView = [[UIImageView alloc] init];
      
      UIImage *strechableImage = [SEPARATOR stretchableImageWithLeftCapWidth:1 topCapHeight:0];
      _separatorImageView = [[UIImageView alloc] initWithImage:strechableImage];
      _separatorImageView.alpha = 0.2f;
      
      _meetingNumberCircle = [[UIImageView alloc] init];
      
      _nameLabel = [[UILabel alloc] init];
      _nameLabel.textColor = WHITE_COLOR;
      _nameLabel.font = NAME_FONT;
      
      _lastMetLabel = [[UILabel alloc] init];
      _lastMetLabel.textColor = WHITE_COLOR;
      _lastMetLabel.font = LAST_MET_FONT;
    }
    return self;
}

-(void)setAvatarWithUrl:(NSString *)url {
  NSURL *URL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
  __weak UIImageView *weakImageView = _avatarImageView;
  [_avatarImageView setImageWithURLRequest:request placeholderImage:nil success:^( NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image ) {
    weakImageView.image = image;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      weakImageView.alpha = 1.0f;
    }];
  } failure:^( NSURLRequest *request, NSHTTPURLResponse *response, NSError *error ) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString( @"Network Error", @"" ) message:NSLocalizedString( @"Avatar image can't be downloaded", @"" ) delegate:nil cancelButtonTitle:@"done" otherButtonTitles:nil];
    [alert show];
  }];

}

-(void)setMeetingNumberCircleImageColor:(ColorType)color {
  if ( color == CTGreen) {
    //set green circle
  }
  if ( color == CTOrange) {
    //set orange circle
  }
  if ( color == CTRed) {
    //set red circle
  }
}

+(FBUserTableViewCell*)createUserTableViewCellWithTableView:(UITableView *)tableView {
  FBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FBUserTableViewCellReuseIdentifier];
  if ( !cell ) {
    cell = [[FBUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FBUserTableViewCellReuseIdentifier];
  }
  return cell;
}

@end
