//
//  PersonListTableViewController.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/26/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "PersonListTableViewController.h"
#import "TweetListTableViewController.h"
#import "PersonModel.h"
#import "NewPostController.h"

@interface PersonListTableViewController ()

@end

@implementation PersonListTableViewController

@synthesize peopleList;

- (id)initWithStyle:(UITableViewStyle)style peepList:(NSArray *)peopleLis
{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *post = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleBordered target:self action:@selector(postButtonClick)];
        self.navigationItem.leftBarButtonItem = post;
        self.title = @"Contacts";
        self.peopleList = peopleLis;
        self.tableView=[[UITableView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame] style:UITableViewStylePlain];
        
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.TabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
        [self.tableView reloadData];
                // Custom initialization
    }
    return self;
}

- (void)childViewController:(NewPostController *)viewController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.view addSubview:act];
    
    [act startAnimating];
    
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
    // return the number of people in the person array
    return self.peopleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    PersonModel *p = [peopleList objectAtIndex:indexPath.row];
    //NSLog(@"%d", peopleList.count);
    cell.textLabel.text = p.name;
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:p.photo]];
    NSData *data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response error:&error];
    UIImage *img = [UIImage imageWithData:data];
    cell.imageView.image = img;
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d tweets", [p.tweets count]];
    // Configure the cell...
    
    return cell;
}

- (void)postButtonClick{
    NewPostController *postcont = [[NewPostController alloc] initWithNibName:@"NewPostController" bundle:[NSBundle mainBundle]];
    
    postcont.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    postcont.delegate = self;
    
    [self presentViewController:postcont animated:NO completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonModel *tempPerson = [self.peopleList objectAtIndex:indexPath.row];
    
    TweetListTableViewController *twitterList = [[TweetListTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:tempPerson.tweets people:peopleList];
    
    [self.navigationController pushViewController: twitterList animated:YES];
}
    //- (NSArray arrayWithContentsOfFile:<#(NSString *)#>)

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
