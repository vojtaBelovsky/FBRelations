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

#define ANIMATION_DURATION  0.2f

@interface FBGalleryCell () {
  UIImageView *_imageView;
}

@end
@implementation FBGalleryCell

#pragma mark - LifeCycles

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if ( self ) {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    
    TMALVariableBindingsAMNO( _imageView );
    TMAL_ADDS_VISUAL( @"H:|-0-[_imageView]-0-|" );
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

- (void)setImageWithId:(NSString *)photoId {
  NSString *graphPath = [NSString stringWithFormat:@"/%@", photoId];
  NSDictionary *params = @{ @"width" : @"640", @"height" : @"640" };
  [FBRequestConnection startWithGraphPath:graphPath
                               parameters:params
                               HTTPMethod:@"GET"
                        completionHandler:^(
                                            FBRequestConnection *connection,
                                            id result,
                                            NSError *error
                                            ) {
                          
                          
                          NSString *url = result[ @"source" ];
                          [self setImageWithUrl:url];
                        }];
}

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
@end