//
//  FBStatisticsView.m
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBStatisticsDetailView.h"

#define ANIMATION_DURATION  0.2f

#define SCROLL_VIEW_OFFSET  64.0f

#define BOTTOM_BACKGROUND_COLOR 

@interface FBStatisticsDetailView () {
  UIImageView *_bottomAvatarView;

  UIView *_bottomView;
  
  UIToolbar *_bottomBlur;
}

@end

@implementation FBStatisticsDetailView

- (id)init
{
  self = [super init];
  if (self) {
    _tableView = [[UITableView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
    _bottomView = [[UIView alloc] init];
//    [_bottomView setBackgroundColor:];
    
    [self initializeConstraints];
  }
  return self;
}

- (void)initializeConstraints {
  TMALVariableBindingsAMNO( _tableView, _bottomView );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_tableView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:|-64-[_tableView]-100-|" );
  
  TMAL_ADDS_VISUAL( @"H:|-0-[_bottomView]-0-|" );
  TMAL_ADDS_VISUAL( @"V:[_tableView]-0-[_bottomView]-0-|" );

}

@end
