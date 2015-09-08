//
//  FriendsViewControllerTableViewController.m
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/14/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import "FriendsViewControllerTableViewController.h"
#import "EditFriendsViewControllerTableViewController.h"

@interface FriendsViewControllerTableViewController ()

@end

@implementation FriendsViewControllerTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];//

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEditFriends"]) {
        EditFriendsViewControllerTableViewController *viewcontroller = (EditFriendsViewControllerTableViewController *)segue.destinationViewController;
        viewcontroller.friendsListInEditView = [NSMutableArray arrayWithArray:self.friends];
        
    }
}
//writing the code in this viewWillAppear will load the friendsList with the updated value
-(void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
   // self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
      self.friendsRelation = [[PFUser currentUser] objectForKey:@"friendsRelation"];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            self.friends = objects;
            [self.tableView reloadData];
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
    return [self.friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];//forIndexPath:indexPath];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    return cell;
    
}



@end
