//
//  FBUserDetailDataSource.h
//  FBRelations
//
//  Created by Daniel Krezelok on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBUserDetailDataSource : NSObject<UICollectionViewDataSource>

@property (strong) NSArray *photos;
@property (strong) NSArray *musics;
@property (strong) NSArray *books;
@property (strong) NSArray *movies;

@property (readonly) NSArray *items;
@property (readonly) NSArray *headerTitles;

- (CGFloat)collectionViewHeight;
@end
