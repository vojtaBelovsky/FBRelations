//
//  Meeting.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 21/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Meeting : NSManagedObject

@property (nonatomic, retain) NSString * adress;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * userId;

@end
