//
//  LoginViewController.m
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/10/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//





#import "LoginViewController.h"
#import <Parse/Parse.h>
@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title = @"Rat Chat";
    //self.navigationItem.hidesBackButton = YES;

     self.hidesBottomBarWhenPushed = YES;

    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

//    self.navigationItem.title = @"Rat Chat";
    //self.navigationItem.hidesBackButton = YES;
  
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   
    self.navigationItem.hidesBackButton = YES;
  //  self.navigationItem.backBarButtonItem.title =@" ";
    self.hidesBottomBarWhenPushed = YES;

}

-(void)dismissKeyboard {
    [self.usernameField2 resignFirstResponder];
    [self.passwordField2 resignFirstResponder];
    
    
}

-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}


- (IBAction)loginButton:(id)sender {

    NSString *username = [self.usernameField2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.view endEditing:YES];
    NSString *password = [self.passwordField2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.view endEditing:YES];//
    
    if([username length] == 0 || [password length] == 0 ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter a username and password " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        
        
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
        
       [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
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
