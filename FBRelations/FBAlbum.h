//
//  FBAlbum.h
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@class FBUser;

@interface FBAlbum : MTLModel<MTLJSONSerializing>

@property (readonly) NSNumber *canUpload;
@property (readonly) NSNumber *count;
@property (readonly) NSString *coverPhoto;
@property (readonly) NSString *createdTime;
@property (readonly) NSString *albumId;
@property (readonly) NSString *link;
@property (readonly) NSString *name;
@property (readonly) NSString *privacy;
@property (readonly) NSString *type;
@property (readonly) NSString *updatedTime;
@property (readonly) FBUser *from;

@end
