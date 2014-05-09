//
//  TweetModel.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/2/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "TweetModel.h"

@implementation TweetModel

@synthesize tweetName;
@synthesize tweetText;
@synthesize tweetDate;

-(id)initWithTweet:(NSString *)tweetNam text:(NSString *)tweetTex date:(NSString *)tweetDat{
    self = [super init];
    if (self){
        self.tweetName = tweetNam;
        self.tweetText = tweetTex;
        self.tweetDate = tweetDat;
    }
    return self;
}

@end
