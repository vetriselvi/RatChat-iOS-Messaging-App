//
//  CameraViewController.m
//  snapchatRibbit
//
//  Created by Vetri Selvi Vairamuthu on 7/23/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.recipients = [[NSMutableArray alloc]init];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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

    if (self.image == nil && [self.videoFilePath length] == 0) {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.videoMaximumDuration = 10;//10 sec
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    [self  presentViewController:self.imagePicker animated:NO completion:nil];
    }
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
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];//forIndexPath:indexPath];
    PFUser *user = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    if([self.recipients containsObject:user.objectId]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    PFUser *user =[self.friends objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType==UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.recipients addObject:user.objectId];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.recipients removeObject:user.objectId];
    }
  //  NSLog(@"%@",self.recipients);
}




#pragma mark - UIImagePickerController delegate
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.tabBarController setSelectedIndex:0];
    
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //a pic is taken
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
            //saving the image
        UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
        
    }
    else{
        //video selected
        NSURL *imagePickerURL = [info objectForKey:UIImagePickerControllerMediaURL];
        // self.videoFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        self.videoFilePath = [imagePickerURL path];
        if(self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
            //saving the video
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)){
            UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath, nil, nil, nil);
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - IBAction


- (IBAction)cancel:(id)sender {
    [self reset];
    [self.tabBarController setSelectedIndex:0];
}

//- (IBAction)cancel:(id)sender {
//    self.image = nil;
//    self.videoFilePath = nil;
//    [self.recipients removeAllObjects];
//    [self.tabBarController setSelectedIndex:0];
//}


- (IBAction)send:(id)sender {
    if(self.image ==nil && [self.videoFilePath length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Oops! Try again" message:@"No media file selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [self presentViewController:self.imagePicker animated:NO completion:nil]; }
    else{
        [self uploadMessage];
        //[self reset];
        [self.tabBarController setSelectedIndex:0];
        
    }
    
}



#pragma mark - helper methods
-(void)uploadMessage{
    //check if image or video
    //if image-shrink
    //upload file
    //upload message
    NSData *fileData;
    NSString *fileType;
    NSString *fileName;
    
    //NSData *fileData = [@"Working at Parse is great!" dataUsingEncoding:NSUTF8StringEncoding];
    // PFFile *file = [PFFile fileWithName:@"resume.txt" data:data];
    
    if(self.image!=nil){
        UIImage *newImage =[self resizeImage:self.image toWidth:320.0f andHeight:480.0f];
        fileData = UIImagePNGRepresentation(newImage);
        fileName=@"image.png";
        fileType=@"image";
    }
    else{
        //video message
        fileData = [NSData dataWithContentsOfFile:self.videoFilePath];
        fileName=@"video.mov";
        fileType=@"video";
        
    }
    PFFile *file = [PFFile fileWithName:fileName data:fileData];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *  error) {
        if(error){
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Oops! Try again" message:@"Error while uploading! Try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
            [self presentViewController:self.imagePicker animated:NO completion:nil];
        }
        else{
            //PFObject class for messages
            PFObject *messages = [PFObject objectWithClassName:@"Messages"];
            [messages setObject:file forKey:@"file"];
            [messages setObject:fileType forKey:@"fileType"];
            [messages setObject:self.recipients forKey:@"recipientIds"];
            [messages setObject:[[PFUser currentUser]objectId] forKey:@"senderId"];
            [messages setObject:[[PFUser currentUser]username] forKey:@"senderName"];
            [messages saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
                if(error){
                    
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Oops! Try again" message:@"Error while uploading! Try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertView show];
                    [self presentViewController:self.imagePicker animated:NO completion:nil];
                }
                else{
                    //
                    [self reset];
                }
            }];
        }
    }];
}
-(UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height{
    
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:newRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return resizedImage;
}
- (void)reset {
    self.image = nil;
    self.videoFilePath = nil;
    [self.recipients removeAllObjects];
}


@end
