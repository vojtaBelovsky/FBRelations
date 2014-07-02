//
//  FBUserDetailView.m
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserDetailView.h"
#import <UIImageView+AFNetworking.h>
#import "FBUser.h"
#import "FBLocation.h"

#define ANIMATION_DURATION  0.2f

#define NAME_FONT           [UIFont boldSystemFontOfSize:20.0f]
#define ADDRESS_FONT        [UIFont systemFontOfSize:16.0f]

#define MASK                [UIImage imageNamed:@"mask"]
#define AVATAR_BACKGROUND   [UIImage imageNamed:@"avatarBackground"]
#define HEART               [UIImage imageNamed:@"heart"]

@interface FBUserDetailView () {
  UIScrollView *_scrollView;

  UIImageView *_backgroundView;
  UIImageView *_avatarView;
  UIImageView *_avatarBackgroundView;
  UIImageView *_heartView;
  
  UILabel *_nameLabel;
  UILabel *_addressLabel;
  UILabel *_ageLabel;
  UILabel *_relationLabel;
  
  UIToolbar *_toolbar;
  UIView *_contentView;
}

@end

@implementation FBUserDetailView

#pragma mark - LifeCycles

- (id)init {
  self = [super init];
  if ( self ) {
    _scrollView = [[UIScrollView alloc] init];
    _contentView = [[UIView alloc] init];
    
    _backgroundView = [[UIImageView alloc] init];
    _backgroundView.contentMode = UIViewContentModeScaleAspectFill;

    _avatarBackgroundView = [[UIImageView alloc] initWithImage:AVATAR_BACKGROUND];
    _avatarView = [[UIImageView alloc] init];
    
    _avatarBackgroundView.alpha = 0.0f;
    _avatarView.alpha = 0.0f;
    
    _heartView = [[UIImageView alloc] initWithImage:HEART];
    _heartView.alpha = 0.0f;
    
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.backgroundColor = CLEAR_COLOR;
    _toolbar.barStyle = UIBarStyleBlackOpaque;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = WHITE_COLOR;
    _nameLabel.font = NAME_FONT;

    _addressLabel = [[UILabel alloc] init];
    _addressLabel.textColor = WHITE_COLOR;
    _addressLabel.font = ADDRESS_FONT;

    _ageLabel = [[UILabel alloc] init];
    _ageLabel.textColor = WHITE_COLOR;
    _ageLabel.font = ADDRESS_FONT;

    _relationLabel = [[UILabel alloc] init];
    _relationLabel.textColor = WHITE_COLOR;
    _relationLabel.font = ADDRESS_FONT;
    
    [_contentView addSubview:_backgroundView];
    [_contentView addSubview:_toolbar];
    [_contentView addSubview:_avatarBackgroundView];
    [_contentView addSubview:_avatarView];
    [_contentView addSubview:_nameLabel];
    [_contentView addSubview:_addressLabel];
    [_contentView addSubview:_ageLabel];
    [_contentView addSubview:_relationLabel];
    [_contentView addSubview:_heartView];
    
    [_scrollView addSubview:_contentView];
    [self addSubview:_scrollView];
    
    [self initializeConstraints];
  }
  
  return self;
}

#pragma mark - Public

- (void)setUser:(FBUser *)user {
  [self initializeBackgroundWithUrl:user.cover];
  [self initializeAvatarWithUrl:user.picture];
  [self initializeAgeWithBirthday:user.birthday];
  
  NSString *formattedStr = [NSString stringWithFormat:@"live in %@", user.currentLocation.name];
  
  _nameLabel.text = user.name;
  _addressLabel.text = NSLocalizedString( formattedStr, @"" );
  _relationLabel.text = user.relationStatus;
}

#pragma mark - Private

- (void)initializeAgeWithBirthday:(NSString *)birthday {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"MM/dd/yyyy"];

  NSDate *date = [df dateFromString:birthday];
  NSDate *now = [NSDate date];
  NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                     components:NSYearCalendarUnit
                                     fromDate:date
                                     toDate:now
                                     options:0];
  NSInteger age = [ageComponents year];
  NSString *formattedStr = [NSString stringWithFormat:@"%d years old", age];
  _ageLabel.text = NSLocalizedString( formattedStr, @"" );
}

- (void)initializeAvatarWithUrl:(NSString *)url {
  NSURL *bannerURL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:bannerURL];
  
  __weak UIImageView *weakAvatarView = _avatarView;;
  __weak UIImageView *weakAvatarBackgroundView = _avatarBackgroundView;
  __weak UIImageView *weakHeartView = _heartView;
  [_avatarView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    weakAvatarView.image = image;

    CALayer *mask = [CALayer layer];
    mask.contents = (id)[MASK CGImage];
    mask.frame = CGRectMake( 0, 0, 95.0f, 95.0f );
    weakAvatarView.layer.mask = mask;
    weakAvatarView.layer.masksToBounds = YES;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      weakAvatarView.alpha = 1.0f;
      weakAvatarBackgroundView.alpha = 1.0f;
      weakHeartView.alpha = 1.0f;
      
    }];
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    
  }];
}

- (void)initializeBackgroundWithUrl:(NSString *)url {
  NSURL *bannerURL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:bannerURL];
  
  __weak UIImageView *weakBannerView = _backgroundView;
  
  _backgroundView.alpha = 0.0f;
  [_backgroundView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    weakBannerView.image = image;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      weakBannerView.alpha = 1.0f;
    }];
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    
  }];
}

- (void)initializeConstraints {
  TMALVariableBindingsAMNO( _backgroundView, _toolbar, _scrollView, _contentView, _avatarView, _nameLabel, _addressLabel, _relationLabel, _ageLabel, _avatarBackgroundView, _heartView );
  TMAL_ADDS_VISUAL( @"H:|-0-[_scrollView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_scrollView]-0-|" );

  TMAL_ADDS_VISUAL( @"H:|-0-[_contentView(==320)]" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_contentView(==480)]" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_backgroundView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_backgroundView]-0-|" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_toolbar]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_toolbar]-0-|" );
  
  TMAL_ADDS_VISUAL( @"H:|-16-[_avatarBackgroundView]" );
  TMAL_ADDS_VISUAL( @"V:|-16-[_avatarBackgroundView]" );
  
  TMAL_ADDS_VISUAL( @"H:|-17-[_avatarView(==95)]-15-[_nameLabel]-10-|" );
  TMAL_ADDS_VISUAL( @"V:|-17-[_avatarView(==95)]" );

  TMAL_ADDS_VISUAL( @"V:|-12-[_nameLabel]" );

  TMAL_ADDS_VISUAL( @"H:[_avatarView]-15-[_addressLabel]" );
  TMAL_ADDS_VISUAL( @"V:[_nameLabel]-0-[_addressLabel]" );
  
  TMAL_ADDS_VISUAL( @"H:[_avatarView]-15-[_ageLabel]" );
  TMAL_ADDS_VISUAL( @"V:[_addressLabel]-0-[_ageLabel]" );
  
  TMAL_ADDS_VISUAL( @"H:[_avatarView]-15-[_heartView]" );
  TMAL_ADDS_VISUAL( @"V:[_ageLabel]-16-[_heartView]" );
  
  TMAL_ADDS_VISUAL( @"H:[_heartView]-15-[_relationLabel]" );
  TMAL_ADDS_VISUAL( @"V:[_ageLabel]-15-[_relationLabel]" );
  
  
}

@end
