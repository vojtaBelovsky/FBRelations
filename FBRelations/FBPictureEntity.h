//
//  FBPictureEntity.h
//  FBRelations
//
//  Created by Daniel Krezelok on 03/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBAPI.h"

@protocol FBPictureEntity <NSObject>
@property (readonly) NSString *picture;
@property (readonly) NSString *pictureId;
@property (readonly) NSString *name;
@property (readonly) FBEntityType entityType;

- (NSString *)originalPictureUrlFromDict:(NSDictionary *)dict;
- (NSString *)originalPictureGraphPathWithId:(NSString *)pictureId;
@end
