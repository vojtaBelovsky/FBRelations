//
//  FBUserTableViewCell.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 14/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserTableViewCell.h"

#define NAME_FONT           [UIFont boldSystemFontOfSize:20.0f]
#define LAST_MET_FONT       [UIFont systemFontOfSize:16.0f]

#define MASK                [UIImage imageNamed:@"mask"]
#define AVATAR_BACKGROUND   [UIImage imageNamed:@"avatarBackgroundShadowed"]
#define SEPARATOR           [UIImage imageNamed:@"line"]

@interface FBUserTableViewCell () {
  UIImageView *_avatarView;
  UIImageView *_separatorView;
  UIImageView *_meatingNumber;
  
  UILabel *_nameLabel;
  UILabel *_lastMetLabel;
}

@end

@implementation FBUserTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      _avatarView = [[UIImageView alloc] init];
      _avatarView.alpha = 0.0f;
      
      UIImage *strechableImage = [SEPARATOR stretchableImageWithLeftCapWidth:1 topCapHeight:0];
      _separatorView = [[UIImageView alloc] initWithImage:strechableImage];
      _separatorView.alpha = 0.2f;
      
      _meatingNumber = [[UIImageView alloc] init];
      
      _nameLabel = [[UILabel alloc] init];
      _nameLabel.textColor = WHITE_COLOR;
      _nameLabel.font = NAME_FONT;
      
      _lastMetLabel = [[UILabel alloc] init];
      _lastMetLabel.textColor = WHITE_COLOR;
      _lastMetLabel.font = LAST_MET_FONT;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
