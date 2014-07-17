//
//  FBStatisticsCell.m
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsCell.h"
#import "FBUser.h"
#import <UIImageView+AFNetworking.h>

#define MASK        [UIImage imageNamed:@"mask"]
#define NAME_COLOR  [UIColor blackColor]
#define NAME_FONT   [UIFont boldSystemFontOfSize:14.0f]

#define ANIMATION_DURATION  0.2f

static NSString *kStatisticsCellIdentifier = @"kStatisticsCellIdentifier";

@interface FBStatisticsCell () {
  UIImageView *_imageView;
  UILabel *_nameLabel;
}

@end

@implementation FBStatisticsCell

#pragma mark - LifeCycles

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if ( self ) {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = NAME_COLOR;
    _nameLabel.font = NAME_FONT;
    
    _imageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_nameLabel];
    
    TMALVariableBindingsAMNO( _nameLabel, _imageView );
    TMAL_ADDS_VISUAL( @"H:|-16-[_imageView(==42)]-10-[_nameLabel]-16-|" );
    TMAL_ADDS_VISUAL( @"V:[_imageView(==42)]" );
    
    TMAL_ADDS_CENTERY( _imageView, _imageView.superview );
    TMAL_ADDS_CENTERY( _nameLabel, _nameLabel.superview );
  }

  return self;
}

#pragma mark - Public

- (void)setUser:(FBUser *)user {
  _nameLabel.text = user.name;
  [self initializeAvatarWithUrl:user.picture];
}

#pragma mark - Private

- (void)initializeAvatarWithUrl:(NSString *)url {
  NSURL *bannerURL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:bannerURL];
  
  __weak UIImageView *weakAvatarView = _imageView;;
  [_imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    if ( weakAvatarView.image != image ) {
      weakAvatarView.image = image;
      
      CALayer *mask = [CALayer layer];
      mask.contents = (id)[MASK CGImage];
      mask.frame = CGRectMake( 0, 0, 42.0f, 42.0f );
      weakAvatarView.layer.mask = mask;
      weakAvatarView.layer.masksToBounds = YES;
      [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        weakAvatarView.alpha = 1.0f;
      }];      
    }
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    
  }];
}

#pragma mark - Class

+ (FBStatisticsCell *)createCellWithTableView:(UITableView *)tableView {
  FBStatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:kStatisticsCellIdentifier];
  if ( !cell ) {
    cell = [[FBStatisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kStatisticsCellIdentifier];
  }
  
  return cell;
}

@end
