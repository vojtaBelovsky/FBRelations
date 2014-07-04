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
#import "FBUserDetailHeaderView.h"

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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  FBUserDetailHeaderView *userDetailHeaderView = [FBUserDetailHeaderView createHeaderViewWithCollectionView:collectionView indexPath:indexPath];
  NSString *title = self.headerTitles[ indexPath.section ];
  [userDetailHeaderView setTitle:title];
  
  return userDetailHeaderView;
}

#pragma mark - Public

- (CGFloat)collectionViewHeight {
  CGFloat height = 0;
  NSUInteger multiplier;
  if ( [_photos count] > 0 ) {
    multiplier = ( [_photos count] > 4 )? 2 : 1;
    height += ( multiplier * 50 ) + 50;
  }

  if ( [_musics count] > 0 ) {
    multiplier = ( [_musics count] > 4 )? 2 : 1;
    height += ( multiplier * 50 ) + 50;
  }
  
  return height;
}

#pragma mark - Properties

- (NSArray *)headerTitles {
  NSMutableArray *items = [@[] mutableCopy];
  
  if ( [_photos count] > 0 ) {
    [items addObject:NSLocalizedString( @"Photos", @"" )];
  }
  
  if ( [_musics count] > 0 ) {
    [items addObject:NSLocalizedString( @"Music", @"" )];
  }
  
  return items;
}

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
