//
//  LoginViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/10/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//




#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField2;
@property (weak, nonatomic) IBOutlet UITextField *passwordField2;
- (IBAction)loginButton:(id)sender;

@end
