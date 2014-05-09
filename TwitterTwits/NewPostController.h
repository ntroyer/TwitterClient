//
//  NewPostController.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 3/24/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

@protocol NewPostControllerDelegate;

@interface NewPostController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *postBton;
@property (weak, nonatomic) IBOutlet UIButton *cancelBton;
@property (weak, nonatomic) IBOutlet UITextView *editableText;
@property (strong, nonatomic) ACAccount *account;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccountType *accountType;

@property (nonatomic, weak) id<NewPostControllerDelegate> delegate;

@end

@protocol NewPostControllerDelegate <NSObject>

- (void)childViewController:(NewPostController*)viewController;

@end