//
//  FBUserDetailDataSource.m
//  FBRelations
//
//  Created by Daniel Krezelok on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBUserDetailDataSource.h"
#import "FBUserDetailInfoCell.h"
#import "FBPictureEntity.h"

@implementation FBUserDetailDataSource

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  NSUInteger count = ( [_photos count] > 0 )? 1 : 0;
  count = ( [_musics count] > 0 )? count + 1 : count;
  
  return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  NSArray *array = self.items[ section ];
  return MIN( [array count], 8 );
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FBUserDetailInfoCell *cell = [FBUserDetailInfoCell createCellWithCollectionView:collectionView indexPath:indexPath];
  NSArray *array = self.items[ indexPath.section ];
  id<FBPictureEntity> pictureEntity = array[ indexPath.row ];
  [cell setImageWithUrl:pictureEntity.picture];
  
  return cell;
}

#pragma mark - items

- (NSArray *)items {
  NSMutableArray *items = [@[] mutableCopy];
  
  if ( [_photos count] > 0 ) {
    [items addObject:_photos];
  }
  
  if ( [_musics count] > 0 ) {
    [items addObject:_musics];
  }
  
  return items;
}

@end
