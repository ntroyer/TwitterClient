//
//  PersonModel.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/2/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

@synthesize name;
@synthesize tweets;
@synthesize photo;
@synthesize location;

-(id)initWithUser:(NSString*)nam photo:(NSString *)phot{
    
    self = [super init];
    if (self){
        self.name = nam;
        self.photo = phot;
    }
    return self;
}

@end
