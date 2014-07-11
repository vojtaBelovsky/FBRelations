//
//  FBUserDetailHeaderView.m
//  FBRelations
//
//  Created by Daniel Krezelok on 03/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserDetailHeaderView.h"

#define FONT  [UIFont boldSystemFontOfSize:14.0f]
#define COLOR [UIColor lightGrayColor]

@interface FBUserDetailHeaderView () {
  UILabel *_titleLabel;
}

@end

@implementation FBUserDetailHeaderView

#pragma mark - LifeCycles

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = WHITE_COLOR;
    _titleLabel.font = FONT;
    
    [self addSubview:_titleLabel];
    
    TMALVariableBindingsAMNO( _titleLabel );
    TMAL_ADDS_VISUAL( @"H:|-0-[_titleLabel]" );
    TMAL_ADDS_CENTERY( _titleLabel, _titleLabel.superview );
  }
  
  return self;
}

#pragma mark - Public

- (void)setTitle:(NSString *)title {
  _titleLabel.text = title;
}

#pragma mark - Class

+ (FBUserDetailHeaderView *)createHeaderViewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
  
  FBUserDetailHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserDetailHeaderIdentifier forIndexPath:indexPath];
  
  return headerView;
}

@end
