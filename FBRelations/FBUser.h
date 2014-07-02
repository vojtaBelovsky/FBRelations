//
//  FBUser.h
//  FBRelations
//
//  Created by Daniel Krezelok on 30/06/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface FBUser : MTLModel<MTLJSONSerializing>

@property (readonly) NSString *firstName;
@property (readonly) NSString *lastName;
@property (readonly) NSString *gender;
@property (readonly) NSString *userId;
@property (readonly) NSString *link;
@property (readonly) NSString *locale;
@property (readonly) NSString *name;
@property (readonly) NSNumber *timezone;
@property (readonly) NSString *updateTime;
@property (readonly) NSNumber *verified;
@property (readonly) NSString *picture;
@property (readonly) NSString *cover;
- (id)initWithUserId:(NSString *)userId;
@end
