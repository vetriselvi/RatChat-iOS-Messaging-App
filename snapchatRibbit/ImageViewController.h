//
//  ImageViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 9/6/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (nonatomic, strong) PFObject *message;
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
