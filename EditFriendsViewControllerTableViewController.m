//
//  EditFriendsViewControllerTableViewController.m
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/12/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import "EditFriendsViewControllerTableViewController.h"
#import <Parse/Parse.h>
@interface EditFriendsViewControllerTableViewController ()

@end

@implementation EditFriendsViewControllerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"Error: %@ %@", error,[error userInfo]);
        }
        else{
            self.allUsers = objects;
            
          //  query.findObjects
          //  NSLog(@"All Users %@",self.allUsers);
            //to tell tableview that new data is available
            [self.tableView reloadData];
        }
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.currentUser = [PFUser currentUser];
}


#pragma mark - Table view delegate

    //[self.tableView deselectRowAtIndexPath:indexPath animated:NO];

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    if([self isFriend:user]){
        
        cell.accessoryType  = UITableViewCellAccessoryNone;
        for (PFUser *friend in self.friendsListInEditView){
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friendsListInEditView removeObject:friend];
                break;
            }
        }
        [friendsRelation removeObject:user];
        
    }
    else {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
   // NSLog(@"dkfjsdlfjsldfjldkjf %@",cell.accessoryView );
      [self.friendsListInEditView addObject:user];
        [friendsRelation addObject:user];
    }
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){;
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row ];
    cell.textLabel.text = user.username;
    if([self isFriend:user]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - Helper methods
-(BOOL) isFriend:(PFUser *)user{
    for (PFUser *friend in self.friendsListInEditView){
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    return NO;
}



@end
