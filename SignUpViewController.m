//
//  SignUpViewController.m
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/10/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//


#import "SignUpViewController.h"
#import <Parse/Parse.h>
@interface SignUpViewController ()

@end

@implementation SignUpViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Rat Chat";
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    self.hidesBottomBarWhenPushed = YES;

    self.navigationItem.title = @"Rat Chat";
    self.navigationItem.hidesBackButton = NO;

    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Go back"
                                      style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil] ;
    self.hidesBottomBarWhenPushed = YES;



}

-(void)dismissKeyboard {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.emailField resignFirstResponder];


}



- (IBAction)signupButton:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.view endEditing:YES];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.view endEditing:YES];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.view endEditing:YES];//
    
    if([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username, password or email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        
      
        [alertView show ];
        
//iOS8
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
//                                                                       message:@"This is an alert."
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}];
//        
//        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    else {
        
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        [self.view endEditing:YES];
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if(error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else {
                
                
                
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
    }
    
}
@end
