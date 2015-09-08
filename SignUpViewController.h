//
//  SignUpViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/10/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)signupButton:(id)sender;

@end
