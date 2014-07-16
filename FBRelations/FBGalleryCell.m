//
//  FBGalleryCell.m
//  FBRelations
//
//  Created by Daniel Krezelok on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBGalleryCell.h"
#import <UIImageView+AFNetworking.h>
#import <FBRequestConnection.h>
#import "FBPhoto.h"
#import <Mantle/Mantle.h>
#import "FBPictureEntity.h"

#define ANIMATION_DURATION  0.2f
#define OVERALY_ALPHA       0.7f
#define OVERALY_BACKGROUND  [UIColor blackColor]

#define NAME_FONT [UIFont systemFontOfSize:14.0f]

@interface FBGalleryCell () {
  UIImageView *_imageView;
  
  UILabel *_nameLabel;
  UIView *_overalyView;
}

@end
@implementation FBGalleryCell

#pragma mark - LifeCycles

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    
    _overalyView = [[UIView alloc] init];
    _overalyView.backgroundColor = OVERALY_BACKGROUND;
    _overalyView.alpha = OVERALY_ALPHA;
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = WHITE_COLOR;
    _nameLabel.font = NAME_FONT;
    _nameLabel.numberOfLines = 2;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;

    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_overalyView];
    [self.contentView addSubview:_nameLabel];
    
    TMALVariableBindingsAMNO( _imageView );

    TMAL_ADDS_VISUAL( @"H:|-10-[_imageView]-10-|" );
    TMAL_ADDS_VISUAL( @"V:|-0-[_imageView]-0-|" );
  }
  
  return self;
}

#pragma mark - Class

+ (FBGalleryCell *)createCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
  FBGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGalleryCellIdentifier forIndexPath:indexPath];
  return cell;
}

#pragma mark - Public

- (void)setImageWithEntity:(id<FBPictureEntity>)pictureEntity {
  _nameLabel.text = pictureEntity.name;
  [self setImageWithUrl:pictureEntity.picture];
  NSDictionary *params = @{ @"width" : @"320", @"height" : @"320" };
  
  __block FBGalleryCell *cell = self;
  [FBRequestConnection startWithGraphPath:[pictureEntity originalPictureGraphPathWithId:pictureEntity.pictureId]
                               parameters:params
                               HTTPMethod:@"GET"
                        completionHandler:^(
                                            FBRequestConnection *connection,
                                            id result,
                                            NSError *error
                                            ) {
                          
                          NSString *url = [pictureEntity originalPictureUrlFromDict:result];
                          [cell setImageWithUrl:url];
                        }];
}

- (void)setImageWithUrl:(NSString *)url {
  NSURL *URL = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
  __weak UIImageView *weakImageView = _imageView;
  __weak FBGalleryCell *weakSelf = self;
  [_imageView setImageWithURLRequest:request placeholderImage:nil success:^( NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image ) {
    weakImageView.image = image;
    [weakSelf initializeNameLabel];
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      weakImageView.alpha = 1.0f;
    }];
    
  } failure:^( NSURLRequest *request, NSHTTPURLResponse *response, NSError *error ) {
    
  }];
}

- (void)initializeNameLabel {
  float x = 0.0f;
  float y = 0.0f;
  float w = 0.0f;
  float h = 0.0f;
  
  CGFloat horizontalRatio = CGRectGetWidth( _imageView.frame ) / _imageView.image.size.width;
  CGFloat verticalRatio = CGRectGetHeight( _imageView.frame ) / _imageView.image.size.height;
  CGFloat ratio = ratio = MIN( horizontalRatio, verticalRatio );
  
  w = _imageView.image.size.width * ratio;
  h = _imageView.image.size.height * ratio;
  x = ( horizontalRatio == ratio ? 0 : ( ( CGRectGetWidth( _imageView.frame )  - w ) / 2 ) );
  y = ( verticalRatio == ratio ? 0 : ( ( CGRectGetHeight( _imageView.frame ) - h ) / 2 ) );
  
  CGRect frame = { x + 15.0f, y + h - 48.0f, w - 10.0f, 48.0f };
  _nameLabel.frame = frame;
  
  frame = (CGRect){ x + 10.0f, y + h - 50.0f, w, 50.0f };
  _overalyView.frame = frame;
  
}

- (void)enableFullScreenMode:(BOOL)enable {
  CGFloat overalyAlpha;
  CGFloat alpha;
  if ( enable ) {
    overalyAlpha = 0.0f;
    alpha = 0.0f;
  } else {
    overalyAlpha = OVERALY_ALPHA;
    alpha  = 1.0f;
  }
  

  [UIView animateWithDuration:ANIMATION_DURATION animations:^{
    _nameLabel.alpha = alpha;
    _overalyView.alpha = overalyAlpha;
  }];
}

@end
