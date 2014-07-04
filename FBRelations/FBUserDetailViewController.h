//
//  FBUserDetailViewController.h
//  FBRelations
//
//  Created by Daniel Krezelok on 27/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class FBUserDetailView;

@interface FBUserDetailViewController : UIViewController<UICollectionViewDelegate, CLLocationManagerDelegate>

@property (readonly) FBUserDetailView *userDetailView;
- (id)initWithUserId:(NSString *)userId;
@end
