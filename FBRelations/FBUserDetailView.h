//
//  FBUserDetailView.h
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBUser;

@interface FBUserDetailView : UIView
- (void)setUser:(FBUser *)user;

@property (readonly) UICollectionView *collectionView;
@end
