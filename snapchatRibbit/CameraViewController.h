//
//  CameraViewController.h
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/23/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface CameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong,nonatomic) UIImagePickerController *imagePicker;
@property(strong,nonatomic) UIImage *image;
@property(strong,nonatomic) NSString *videoFilePath;
@property(strong,nonatomic) NSArray *friends;
@property(strong,nonatomic) NSMutableArray *recipients;
@property(strong,nonatomic) PFRelation *friendsRelation;

- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;


- (void)uploadMessage;
- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;

@end
