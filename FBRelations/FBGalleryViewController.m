//
//  FBGalleryViewController.m
//  FBRelations
//
//  Created by Daniel Krezelok on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import "FBGalleryViewController.h"
#import "FBGalleryDataSource.h"
#import "FBGalleryCell.h"

#define ANIMATION_DURATION  0.2f

@interface FBGalleryViewController () {
  FBGalleryDataSource *_dataSource;
}

@end

@implementation FBGalleryViewController

#pragma mark - LifeCycles

- (id)initWithItems:(NSArray *)items startIndex:(NSUInteger)index {
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  flowLayout.itemSize = (CGSize){ CGRectGetWidth( [UIScreen mainScreen].bounds ), CGRectGetHeight( [UIScreen mainScreen].bounds ) - 64.0f};
  flowLayout.minimumLineSpacing = 0;
  self = [super initWithCollectionViewLayout:flowLayout];
  if ( self ) {
    _dataSource = [[FBGalleryDataSource alloc] initWithItems:items startIndex:index];
    self.title = NSLocalizedString( @"Gallery", @"" );
  }
  
  return self;
}

- (void)loadView {
  [super loadView];
  
  self.view.backgroundColor = [UIColor blackColor];
  self.collectionView.backgroundColor = CLEAR_COLOR;
  [self.collectionView registerClass:[FBGalleryCell class] forCellWithReuseIdentifier:kGalleryCellIdentifier];
  
  self.collectionView.showsVerticalScrollIndicator = NO;
  self.collectionView.showsHorizontalScrollIndicator = NO;
  
  self.collectionView.dataSource = _dataSource;
  self.collectionView.pagingEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  CGPoint offset = { _dataSource.startIndex * CGRectGetWidth( [UIScreen mainScreen].bounds ), 0.0f };
  [self.collectionView setContentOffset:offset];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  _dataSource.fullScreenMode = !_dataSource.fullScreenMode;
  CGFloat alpha = ( _dataSource.fullScreenMode )? 0.0f : 1.0f;
  FBGalleryCell *cell = (FBGalleryCell *)[collectionView cellForItemAtIndexPath:indexPath];
  [cell enableFullScreenMode:_dataSource.fullScreenMode];
  [UIView animateWithDuration:ANIMATION_DURATION animations:^{
    self.navigationController.navigationBar.alpha = alpha;
  }];
}

@end
