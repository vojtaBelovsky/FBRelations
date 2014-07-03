//
//  FBUserDetailViewController.h
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBUserDetailView;

@interface FBUserDetailViewController : UIViewController<UICollectionViewDelegate>

@property (readonly) FBUserDetailView *userDetailView;
- (id)initWithUserId:(NSString *)userId;
@end
