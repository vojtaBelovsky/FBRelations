//
//  FBLightboxDataSource.h
//  FBRelations
//
//  Created by Daniel Krezelok on 07/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBLightboxDataSource : NSObject<UICollectionViewDataSource>
- (id)initWithItems:(NSArray *)items;

@property (readonly) NSArray *items;
@end
