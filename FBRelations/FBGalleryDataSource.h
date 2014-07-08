//
//  FBGalleryDataSource.h
//  FBRelations
//
//  Created by Daniel Krezelok on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBGalleryDataSource : NSObject<UICollectionViewDataSource>

@property (readonly) NSArray *items;
@property (readonly) NSUInteger startIndex;
- (id)initWithItems:(NSArray *)items startIndex:(NSUInteger)startIndex;
@end
