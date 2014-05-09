//
//  WebbViewController.m
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/25/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import "WebbViewController.h"

@interface WebbViewController ()

@end

@implementation WebbViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)loadRequest:(NSURLRequest *)request;
//call loadrequest

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
