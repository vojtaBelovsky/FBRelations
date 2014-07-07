//
//  FBLightboxDataSource.m
//  FBRelations
//
//  Created by Daniel Krezelok on 07/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBLightboxDataSource.h"
#import "FBPictureEntity.h"
#import "FBUserDetailInfoCell.h"

@implementation FBLightboxDataSource

#pragma mark - LifeCycles

- (id)initWithItems:(NSArray *)items {
  self = [super init];
  if ( self ) {
    _items = items;
  }
  
  return self;
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  FBUserDetailInfoCell *cell = [FBUserDetailInfoCell createCellWithCollectionView:collectionView indexPath:indexPath];
  id<FBPictureEntity> pictureEntity = _items[ indexPath.row ];
  [cell setImageWithUrl:pictureEntity.picture];
  
  return cell;
}


@end
