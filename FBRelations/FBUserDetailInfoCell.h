//
//  FBUserDetailInfoCell.h
//  FBRelations
//
//  Created by Daniel Krezelok on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kUserDetailInfoCellIdentifier = @"kUserDetailInfoCellIdentifier";

@interface FBUserDetailInfoCell : UICollectionViewCell
+ (FBUserDetailInfoCell *)createCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
- (void)setImageWithUrl:(NSString *)url;
@end
