//
//  TweetListTableViewController.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/26/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetListTableViewController : UITableViewController
@property NSArray *tweets;
@property NSArray *people;

- (id)initWithStyle:(UITableViewStyle)style tweets:(NSArray *)tweetss people:(NSArray *)peoplee;
@end
