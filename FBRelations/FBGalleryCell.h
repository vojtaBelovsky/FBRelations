//
//  FBGalleryCell.h
//  FBRelations
//
//  Created by Daniel Krezelok on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FBPictureEntity;

static NSString *kGalleryCellIdentifier = @"kGalleryCellIdentifier";

@interface FBGalleryCell : UICollectionViewCell
+ (FBGalleryCell *)createCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
- (void)setImageWithUrl:(NSString *)url;
- (void)setImageWithEntity:(id<FBPictureEntity>)pictureEntity;
@end
