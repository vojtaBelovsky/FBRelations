//
//  FBStatisticsViewController.h
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocation;

@interface FBStatisticsViewController : UITableViewController
- (void)addNewUserWithFacebookId:(NSString *)facebookId withLocation:(CLLocation *)location;
- (BOOL)containsUserWithMinor:(NSNumber *)minor major:(NSNumber *)major;
@end
