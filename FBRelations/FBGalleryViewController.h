//
//  FBGalleryViewController.h
//  FBRelations
//
//  Created by Daniel Krezelok on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBGalleryViewController : UICollectionViewController
- (id)initWithItems:(NSArray *)items startIndex:(NSUInteger)index;
@end
