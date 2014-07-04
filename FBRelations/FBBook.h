//
//  FBBook.h
//  FBRelations
//
//  Created by Daniel Krezelok on 04/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FBPictureEntity.h"

@interface FBBook : MTLModel<FBPictureEntity, MTLJSONSerializing>

@property (readonly) NSString *category;
@property (readonly) NSString *createdTime;
@property (readonly) NSString *bookId;
@property (readonly) NSString *name;

@property (readonly) NSString *picture;
@end
