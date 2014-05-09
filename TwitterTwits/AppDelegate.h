//
//  AppDelegate.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/19/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/SLRequest.h>
#import <Accounts/Accounts.h>
#import <CoreLocation/CoreLocation.h>
#import "PersonListTableViewController.h"
#import "TweetListTableViewController.h"
#import "MapViewer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *TabBar;
@property (strong, nonatomic) IBOutlet UINavigationController *NavCont1;
@property (strong, nonatomic) IBOutlet UINavigationController *NavCont2;
@property (strong, nonatomic) IBOutlet UINavigationController *NavCont3;
@property (strong, nonatomic) PersonListTableViewController *ptvc;
@property (strong, nonatomic) TweetListTableViewController *ttvc;
@property (strong, nonatomic) MapViewer *mapView;
@property (strong, nonatomic) ACAccount *account;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccountType *accountType;
@property (strong, nonatomic) NSDictionary *pulledFromAccount;
@property (strong, nonatomic) NSMutableArray *twitterPeeps;
@property (strong, nonatomic) UIActivityIndicatorView *actInd;

@end
