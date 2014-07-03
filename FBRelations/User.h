//
//  User.h
//  FBRelations
//
//  Created by Vojtech Belovsky on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * lastUpdated;
@property (nonatomic, retain) NSString * locale;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * timezone;
@property (nonatomic, retain) NSString * updateTime;
@property (nonatomic, retain) NSNumber * verified;
@property (nonatomic, retain) NSString * picture;
@property (nonatomic, retain) NSString * cover;
@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * relationStatus;
@property (nonatomic, retain) NSData * coverImage;
@property (nonatomic, retain) NSData * pictureImage;

@end
