//
//  FBGalleryDataSource.m
//  FBRelations
//
//  Created by Daniel Krezelok on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBGalleryDataSource.h"
#import "FBGalleryCell.h"
#import "FBPictureEntity.h"

@implementation FBGalleryDataSource

#pragma mark - LifeCycles

- (id)initWithItems:(NSArray *)items startIndex:(NSUInteger)startIndex {
  self = [super init];
  if ( self ) {
    _items = items;
    _startIndex = startIndex;
  }
  
  return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  id<FBPictureEntity> pictrureEntity = _items[ indexPath.row ];
  FBGalleryCell *cell = [FBGalleryCell createCellWithCollectionView:collectionView indexPath:indexPath];
  [cell setImageWithUrl:pictrureEntity.picture];
  [cell setImageWithId:pictrureEntity.pictureId];
  return cell;
}


@end
