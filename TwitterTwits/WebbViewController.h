//
//  WebbViewController.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/25/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebbViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) NSString *url;

@end
