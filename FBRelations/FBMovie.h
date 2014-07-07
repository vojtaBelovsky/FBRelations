//
//  FBMovie.h
//  FBRelations
//
//  Created by Daniel Krezelok on 01/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FBPictureEntity.h"

@interface FBMovie : MTLModel<MTLJSONSerializing, FBPictureEntity>

@property (readonly) NSString *category;
@property (readonly) NSString *createdTime;
@property (readonly) NSString *musicId;
@property (readonly) NSString *name;
@property (readonly) NSString *picture;
@end
