//
//  NewPostController.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/24/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "NewPostController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface NewPostController ()

@end

@implementation NewPostController

@synthesize postBton;
@synthesize cancelBton;
@synthesize editableText;
@synthesize account;
@synthesize accountStore;
@synthesize accountType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelPost:(id)sender {
    id<NewPostControllerDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(childViewController:)]){
        [strongDelegate childViewController:self];
    }
    //[self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)postToTwitter:(id)sender {
    [self connectToTwitter];
}

- (void)connectToTwitter{
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
                     NSLog(@"No redemption");
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

- (void)makePost{
    NSString *text = self.editableText.text;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:text, @"status", nil];
    
    SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"] parameters:dict];
    
    if (self.account){
        [twitterRequest setAccount: self.account];
        [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            if ([urlResponse statusCode] == 200){
            }
        }];
    }
}

@end
