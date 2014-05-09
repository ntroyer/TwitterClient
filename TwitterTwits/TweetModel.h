//
//  TweetModel.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/2/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetModel : NSObject
@property NSString *tweetName;
@property NSString *tweetText;
@property NSString *tweetDate;

-(id)initWithTweet:(NSString*)tweetNam text:(NSString*)tweetTex date:(NSString*)tweetDat;

@end
