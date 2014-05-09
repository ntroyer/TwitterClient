//
//  PersonListTableViewController.h
//  TwitterTwits
//
//  Created by Troyer, Nathanael, Andrew on 2/26/14.
//  Copyright (c) 2014 Troyer, Nathanael, Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPostController.h"
//@protocol NewPostControllerDelegate;

@interface PersonListTableViewController : UITableViewController <NewPostControllerDelegate>

@property NSArray *peopleList;

-(id)initWithStyle:(UITableViewStyle)style peepList:(NSArray*)peopleList;

//@end

//@protocol NewPostControllerDelegate <NSObject>

@end