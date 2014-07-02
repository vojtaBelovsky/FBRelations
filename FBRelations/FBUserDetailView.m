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

#define ANIMATION_DURATION  0.2f

#define NAME_FONT           [UIFont boldSystemFontOfSize:16.0f]

@interface FBUserDetailView () {
  UIScrollView *_scrollView;

  UIImageView *_backgroundView;
  UIImageView *_avatarView;
  
  UILabel *_nameLabel;
  UILabel *_addressLabel;
  
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
    
    _avatarView = [[UIImageView alloc] init];
    
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.backgroundColor = CLEAR_COLOR;
    _toolbar.barStyle = UIBarStyleBlackOpaque;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = WHITE_COLOR;
    _nameLabel.font = NAME_FONT;
    
    [_contentView addSubview:_backgroundView];
    [_contentView addSubview:_toolbar];
    [_contentView addSubview:_avatarView];
    [_contentView addSubview:_nameLabel];
    
    
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
  _nameLabel.text = user.name;
}

#pragma mark - Private

- (void)initializeAvatarWithUrl:(NSString *)url {
  NSURL *bannerURL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:bannerURL];
  
  __weak UIImageView *weakAvatarView = _avatarView;;
  
  _avatarView.alpha = 0.0f;
  [_avatarView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    weakAvatarView.image = image;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      weakAvatarView.alpha = 1.0f;
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
  TMALVariableBindingsAMNO( _backgroundView, _toolbar, _scrollView, _contentView, _avatarView, _nameLabel );
  TMAL_ADDS_VISUAL( @"H:|-0-[_scrollView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_scrollView]-0-|" );

  TMAL_ADDS_VISUAL( @"H:|-0-[_contentView(==320)]" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_contentView(==480)]" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_backgroundView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_backgroundView]-0-|" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_toolbar]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_toolbar]-0-|" );
  
  TMAL_ADDS_VISUAL( @"H:|-16-[_avatarView(==100)]-10-[_nameLabel]" );
  TMAL_ADDS_VISUAL( @"V:|-16-[_avatarView(==100)]" );

  TMAL_ADDS_VISUAL( @"V:|-16-[_nameLabel]" );
}

@end
