//
//  FBUserDetailHeaderView.h
//  FBRelations
//
//  Created by Daniel Krezelok on 03/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kUserDetailHeaderIdentifier = @"kUserDetailHeaderIdentifier";

@interface FBUserDetailHeaderView : UICollectionReusableView
+ (FBUserDetailHeaderView *)createHeaderViewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
- (void)setTitle:(NSString *)title;
@end
