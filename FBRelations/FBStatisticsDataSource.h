//
//  FBStatisticsDataSource.h
//  FBRelations
//
//  Created by Daniel Krezelok on 16/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBStatisticsDataSource : NSObject<UITableViewDataSource>

@property (strong) NSMutableArray *items;
@end
