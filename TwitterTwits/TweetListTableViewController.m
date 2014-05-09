//
//  TweetListTableViewController.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/26/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "TweetListTableViewController.h"
#import "TweetModel.h"
#import "PersonModel.h"
#import "WebbViewController.h"
#import "AppDelegate.h"

@interface TweetListTableViewController ()

@end

@implementation TweetListTableViewController

@synthesize tweets;
@synthesize people;

- (id)initWithStyle:(UITableViewStyle)style tweets:(NSArray *)tweetss people:(NSArray *)peoplee
{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStyleBordered target:nil action:@selector(makePost)];
        self.navigationItem.rightBarButtonItem = refreshButton;
        
        self.title = @"Tweets";
        self.tweets = tweetss;
        self.people = peoplee;
        self.tableView=[[UITableView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame] style:UITableViewStylePlain];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.TabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
        [self.tableView reloadData];        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }    // Configure the cell...
    TweetModel *t = [tweets objectAtIndex:indexPath.row];
    
    for (PersonModel *p in people){
        if ([t.tweetName isEqualToString:p.name]){
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSURLRequest *request = [NSURLRequest requestWithURL:
                                     [NSURL URLWithString:p.photo]];
            NSData *data = [NSURLConnection
                            sendSynchronousRequest:request
                            returningResponse:&response error:&error];
            UIImage *img = [UIImage imageWithData:data];
            cell.imageView.image = img;
        }
    }
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.textLabel.text = t.tweetText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tweet = [[NSString alloc] init];   // assume already initialized to hold tweet
    TweetModel *t = [tweets objectAtIndex:indexPath.row];
    tweet = t.tweetText;
    NSRange r;
    NSString *regEx = @"http://\\S*";
    r = [tweet rangeOfString:regEx options:NSRegularExpressionSearch];
    if (r.location != NSNotFound) {
        // URL was found
        NSString *url = [tweet substringWithRange:r];
        WebbViewController *webb = [[WebbViewController alloc] initWithNibName:@"WebbViewController" bundle:[NSBundle mainBundle]];
        webb.url = url;
        [self.navigationController pushViewController:webb animated:NO];
    } else {
        // no URL was found
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
