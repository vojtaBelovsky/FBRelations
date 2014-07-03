//
//  FBPhoto.h
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FBPictureEntity.h"

@class FBUser;

@interface FBPhoto : MTLModel<MTLJSONSerializing, FBPictureEntity>

@property (readonly) NSString *picture;
@property (readonly) NSString *createdTime;
@property (readonly) NSString *updatedTime;
@property (readonly) NSString *photoId;
@property (readonly) FBUser *from;
@end
