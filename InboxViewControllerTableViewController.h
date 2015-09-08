//
//  InboxViewControllerTableViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/9/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>

@interface InboxViewControllerTableViewController : UITableViewController


@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessage;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;


- (IBAction)logout:(id)sender;

@end


