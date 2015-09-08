//
//  EditFriendsViewControllerTableViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/12/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface EditFriendsViewControllerTableViewController : UITableViewController
@property (strong,nonatomic) NSArray *allUsers;
@property(strong,nonatomic) PFUser *currentUser;
@property(strong,nonatomic) NSMutableArray *friendsListInEditView;

-(BOOL) isFriend: (PFUser *)user;
@end
