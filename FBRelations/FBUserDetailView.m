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

@interface FBUserDetailView () {
  UIScrollView *_scrollView;
  UIImageView *_backgroundView;
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
    
    _toolbar = [[UIToolbar alloc] init];
    _toolbar.backgroundColor = CLEAR_COLOR;
    _toolbar.barStyle = UIBarStyleBlackOpaque;
    
    [_contentView addSubview:_backgroundView];
    [_contentView addSubview:_toolbar];
    [_scrollView addSubview:_contentView];
    [self addSubview:_scrollView];
    
    [self initializeConstraints];
  }
  
  return self;
}

#pragma mark - Public

- (void)setUser:(FBUser *)user {
  [self initializeBackgroundWithUrl:user.cover];
}

#pragma mark - Private

- (void)initializeBackgroundWithUrl:(NSString *)url {
  NSURL *bannerURL = [NSURL URLWithString:url];
  [_backgroundView setImageWithURL:bannerURL];
}

- (void)initializeConstraints {
  TMALVariableBindingsAMNO( _backgroundView, _toolbar, _scrollView, _contentView );
  TMAL_ADDS_VISUAL( @"H:|-0-[_scrollView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_scrollView]-0-|" );

  TMAL_ADDS_VISUAL( @"H:|-0-[_contentView(==320)]" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_contentView(==480)]" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_backgroundView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_backgroundView]-0-|" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_toolbar]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-0-[_toolbar]-0-|" );
}

@end
