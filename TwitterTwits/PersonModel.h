//
//  PersonModel.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/2/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property NSString *name;
@property NSArray *tweets;
@property NSString *photo;
@property NSString *location;

-(id)initWithUser:(NSString*)name photo:(NSString*)photo;

@end
