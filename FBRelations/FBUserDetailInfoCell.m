//
//  FBUserDetailInfoCell.m
//  FBRelations
//
//  Created by Daniel Krezelok on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserDetailInfoCell.h"
#import <UIImageView+AFNetworking.h>

#define ANIMATION_DURATION  0.2f
#define BACKGROUND          [UIColor lightGrayColor]

@interface FBUserDetailInfoCell () {
  UIImageView *_imageView;
  UIView *_imageContentView;
}

@end

@implementation FBUserDetailInfoCell

#pragma mark - LifeCycles

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    self.clipsToBounds = YES;
    self.contentView.backgroundColor = WHITE_COLOR;
    
    _imageContentView = [[UIView alloc] init];
    _imageContentView.clipsToBounds = YES;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.alpha = 0.0f;
    
    [self.contentView addSubview:_imageContentView];
    [_imageContentView addSubview:_imageView];
    
    TMALVariableBindingsAMNO( _imageContentView, _imageView );
    TMAL_ADDS_VISUAL( @"H:|-2-[_imageContentView]-2-|" );
    TMAL_ADDS_VISUAL( @"V:|-2-[_imageContentView]-2-|" );
    
    TMAL_ADDS_VISUAL( @"H:|-0-[_imageView]-0-|" );
    TMAL_ADDS_VISUAL( @"V:|-0-[_imageView]-0-|" );
    
  }
  
  return self;
}

#pragma mark - Public

- (void)setImageWithUrl:(NSString *)url {
  NSURL *URL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
  __weak UIImageView *weakImageView = _imageView;
  [_imageView setImageWithURLRequest:request placeholderImage:nil success:^( NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image ) {
    weakImageView.image = image;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      weakImageView.alpha = 1.0f;
    }];
  } failure:^( NSURLRequest *request, NSHTTPURLResponse *response, NSError *error ) {
    
  }];
}

#pragma mark - Class

+ (FBUserDetailInfoCell *)createCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
  FBUserDetailInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserDetailInfoCellIdentifier forIndexPath:indexPath];
  
  return cell;
}

@end
