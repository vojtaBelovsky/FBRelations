//
//  FBStatisticDataSource.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 08/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FBUser;

@interface FBStatisticDataSource : NSObject<UITableViewDataSource>

@property FBUser *user;
@property NSArray *meetings;

@end
