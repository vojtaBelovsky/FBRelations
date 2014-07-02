//
//  FBLocation.h
//  FBRelations
//
//  Created by Daniel Krezelok on 02/07/14.
//  Copyright (c) 2014 Daniel Krezelok. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FBLocation : MTLModel<MTLJSONSerializing>

@property (readonly) NSString *locationId;
@property (readonly) NSString *name;
@end
