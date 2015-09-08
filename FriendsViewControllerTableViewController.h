//
//  FriendsViewControllerTableViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/14/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface FriendsViewControllerTableViewController : UITableViewController
@property (nonatomic,strong) PFRelation *friendsRelation;
@property (nonatomic,strong) NSArray *friends;
//@property (nonatomic,strong) PFUser *user;
@end
