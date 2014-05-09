//
//  AppDelegate.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/19/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//  twitterPeeps doesn't get added to; ask the TF why

#import "AppDelegate.h"
#import "PersonModel.h"
#import "TweetModel.h"

@implementation AppDelegate

@synthesize window;
@synthesize TabBar;
@synthesize NavCont1;
@synthesize NavCont2;
@synthesize NavCont3;
@synthesize ptvc;
@synthesize ttvc;
@synthesize mapView;
@synthesize account;
@synthesize accountStore;
@synthesize accountType;
@synthesize pulledFromAccount;
@synthesize twitterPeeps;
@synthesize actInd;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // read in NSArray
    self.actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.actInd.center = self.window.rootViewController.view.center;
    self.actInd.hidesWhenStopped = YES;
    
    [self connectToTwitter];
    
    NSString *tweetsPath = [[NSBundle mainBundle] pathForResource:@"TestTweets" ofType:@"plist"];
    NSArray *tweetsData = [NSArray arrayWithContentsOfFile:tweetsPath];
    NSMutableArray *tweetsList = [NSMutableArray array];
    
    for (NSDictionary *dict in tweetsData){
        NSString *username = [dict objectForKey:@"user"];
        NSString *txt = [dict objectForKey:@"text"];
        NSString *date = [dict objectForKey:@"date"];
        TweetModel *tweet = [[TweetModel alloc] init];
        tweet = [tweet initWithTweet:username text:txt date:date];
        [tweetsList addObject:tweet];
    }
    
    NSMutableArray *finalPersonList = [[NSMutableArray alloc] init];
    NSMutableArray *finalTweetList = [[NSMutableArray alloc] init];
    
    for (PersonModel *o in self.twitterPeeps){
        [finalPersonList addObject: o];
    }
    
    for (int i = 0; i < tweetsList.count; i++){
        [finalTweetList addObject:[tweetsList objectAtIndex:i]];
    }
    
    self.TabBar.title = @"Contacts";
    self.TabBar = [[UITabBarController alloc] init];
    self.NavCont1 = [[UINavigationController alloc] init];
    self.NavCont2 = [[UINavigationController alloc] init];
    self.NavCont3 = [[UINavigationController alloc] init];
    self.window.rootViewController = self.TabBar;
    self.NavCont1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Contacts" image:[UIImage imageNamed:@"e.jpg"] tag:0];
    
    self.ptvc = [[PersonListTableViewController alloc] initWithStyle:UITableViewStylePlain peepList:finalPersonList];
    
    self.ttvc = [[TweetListTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:finalTweetList people:finalPersonList];
    [self.NavCont1 pushViewController:ptvc animated:NO];
    self.NavCont2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Recents" image:[UIImage imageNamed:@"m.jpg"] tag:0];
    self.NavCont2.title = @"Recents";
    [self.NavCont2 pushViewController:ttvc animated:NO];
    
    self.mapView = [[MapViewer alloc] initWithNibName:@"MapViewer" bundle:[NSBundle mainBundle]];
    self.NavCont3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image: [UIImage imageNamed:@"b.jpg"] tag:0];
    self.NavCont3.title = @"Map";
    [self.NavCont3 pushViewController:mapView animated:NO];
    NSArray *myViewControllers = @[NavCont1, NavCont2, NavCont3];
    self.TabBar.viewControllers = myViewControllers;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
   // tabBarController = [[UITabBarController alloc]init];
    // tabBarController.viewControllers = myViewControllers;
}

- (void)connectToTwitter
{
    self.account.username = @"bucs211f11";
    
    if (self.account == nil)
    {
        if (self.accountStore == nil)
        {
            self.accountStore = [[ACAccountStore alloc] init];
        }
        ACAccountType *accountTypeTwitter =
        [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [self.accountStore requestAccessToAccountsWithType:accountTypeTwitter options:nil completion:^(BOOL granted, NSError *error)
         {
             if(granted)
             {
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     self.account = [self.accountStore
                                     accountsWithAccountType:accountTypeTwitter][0];
                     [self makePost];
                     // update the data store and reload the tableviews
                     // eg: [self refreshData];
                 });
             }
         }];
    }
}

- (void)makePost
{
    
    [self.window.rootViewController.view bringSubviewToFront:self.actInd];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.actInd startAnimating];
        [self.window.rootViewController.view addSubview:self.actInd];
    });
        NSURL *url = [NSURL URLWithString: @"https://api.twitter.com/1.1/statuses/home_timeline.json" ];
        SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                    requestMethod:SLRequestMethodGET
                                                              URL:url
                                                       parameters:nil];
        if (self.account){
            [postRequest setAccount: self.account];
            [postRequest performRequestWithHandler:^(NSData *responseData,
                                                     NSHTTPURLResponse *urlResponse,
                                                     NSError *error) {
                if ([urlResponse statusCode] == 200)
                {
                    NSError *jsonError = nil;
                    id jsonResult = [NSJSONSerialization JSONObjectWithData:responseData
                                                                    options:0
                                                                      error:&jsonError];
                    if (jsonResult != nil)
                    {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            NSMutableArray *personList = [[NSMutableArray alloc] init];
                            NSMutableArray *personNames = [[NSMutableArray alloc] init];
                            for (NSDictionary *item in jsonResult){
                                
                                PersonModel *p = [[PersonModel alloc] initWithUser:item[@"user"][@"screen_name"] photo:item[@"user"][@"profile_image_url"]];
                                
                                p.location = item[@"user"][@"location"];
                                
                                if (![personNames containsObject:p.name]){
                                    [personNames addObject:p.name];
                                    [personList addObject:p];
                                }
                                
                                
                                
                            }
                            NSMutableArray *tweetList = [[NSMutableArray alloc] init];
                            for (PersonModel *l in personList){
                                NSMutableArray *personTweets = [[NSMutableArray alloc] init];
                                for (NSDictionary *item in jsonResult){
                                    TweetModel *t = [[TweetModel alloc] initWithTweet:item[@"user"][@"screen_name"] text:item[@"text"] date:item[@"created_at"]];
                                    
                                    if ([l.name isEqualToString:t.tweetName]){
                                        [personTweets addObject:t];
                                        [tweetList addObject:t];
                                    }
                                }
                                l.tweets = personTweets;
                            }
                            self.twitterPeeps = personList;
                            self.pulledFromAccount = jsonResult;
                            self.ptvc.peopleList = personList;
                            self.ttvc.tweets = tweetList;
                            self.ttvc.people = personList;
                            self.mapView.peopleList = personList;
                            //update
                            [self.ptvc.tableView reloadData];
                            [self.ttvc.tableView reloadData];
                            [self.actInd stopAnimating];
                            // here, update your model using jsonResult
                        });
                    }
                    else {
                        NSString *message = [NSString
                                             stringWithFormat:@"Could not parse your timeline: %@",
                                             [jsonError localizedDescription]];
                        [[[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:nil]
                         show];
                        [self.actInd stopAnimating];
                    }
                }
            }];
        }
    

    ///});
    
}

@end
