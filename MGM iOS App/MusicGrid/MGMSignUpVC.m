//
//  SLFSignInVC.m
//  Selfie
//
//  Created by Jonathan Fox on 4/28/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "MGMSignUpVC.h"
#import <Parse/Parse.h>
#import "MGMCollectionViewController.h"
#import "MGMData.h"
#import "MGMArtistsViewController.h"

@interface MGMSignUpVC () <UITextFieldDelegate, FBLoginViewDelegate>

@property (strong, nonatomic) FBProfilePictureView *profilePic;

@property (strong, nonatomic) UILabel *labelFirstName;
@property (strong, nonatomic)  FBProfilePictureView *profilePictureView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *statusLabel;

@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@end

@implementation MGMSignUpVC

{
    UITextField * userNameLabel;
 //   UITextField * nameLabel;
    UITextField * passwordLabel;
    UITextField * emailLabel;
    UIActivityIndicatorView * spinner;
    UIView *newForm;
//    UIImageView *avatar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithRed:0.016f green:0.863f blue:0.529f alpha:1.0f];
    
    UIImageView * signUpBackground = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,568, 315)];
    signUpBackground.contentMode = UIViewContentModeScaleToFill;
    signUpBackground.image = [UIImage imageNamed:@"popup"];
    [self.view addSubview:signUpBackground];
    
    UIImageView * closeButton = [[UIImageView alloc]initWithFrame:CGRectMake(523,10,29,29)];
    closeButton.contentMode = UIViewContentModeScaleToFill;
    closeButton.image = [UIImage imageNamed:@"close_button"];
    [signUpBackground addSubview:closeButton];
    
    
    newForm = [[UIView alloc] initWithFrame:CGRectMake(0, -50, 320, self.view.frame.size.height)];
   
    [self.view addSubview:newForm];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-150), 60, 300, 100)];
    title.text = @"My Music Pulse";
    title.textAlignment = 1;
    title.font = [UIFont fontWithName:@"HelveticaNeue-ultralight" size:30.0];
    
    UIImageView * plug = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30,150, 40)];
    plug.image = [UIImage imageNamed:@"jack"];
    plug.contentMode = UIViewContentModeScaleToFill;
    [signUpBackground addSubview:plug];
    
    title.textAlignment = 1;
    [newForm addSubview:title];
    
    
    userNameLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 150, 200, 40)];
    userNameLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    userNameLabel.layer.cornerRadius = 4;
    userNameLabel.delegate = self;
    userNameLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    userNameLabel.leftViewMode = UITextFieldViewModeAlways;
    userNameLabel.placeholder = @" Enter user name";
    userNameLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    userNameLabel.delegate = self;
    
    [newForm addSubview:userNameLabel];
    
    passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 200, 200, 40)];
    passwordLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    passwordLabel.layer.cornerRadius = 4;
    passwordLabel.delegate = self;
    passwordLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    passwordLabel.leftViewMode = UITextFieldViewModeAlways;
    passwordLabel.placeholder = @" Enter password";
    passwordLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    passwordLabel.secureTextEntry = YES;
    
    passwordLabel.delegate = self;
    
    [newForm addSubview:passwordLabel];
    
    emailLabel = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-100), 250, 200, 40)];
    emailLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.05];
    emailLabel.layer.cornerRadius = 4;
    emailLabel.delegate = self;
    emailLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    emailLabel.leftViewMode = UITextFieldViewModeAlways;
    emailLabel.placeholder = @" Enter email";
    emailLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    emailLabel.keyboardType = UIKeyboardTypeEmailAddress;
    
    emailLabel.delegate = self;
    
    [newForm addSubview:emailLabel];
    
    
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-160), 300, 110, 45)];
    [submitButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor colorWithRed:0.227f green:0.337f blue:0.580f alpha:1.0f];
    submitButton.layer.cornerRadius = 4;
    [newForm addSubview:submitButton];
    
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelLogin)];
    
    cancelButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends", @"user_likes"]];
    
    loginView.frame = CGRectMake((SCREEN_WIDTH/2-50), 275, 50, 40);
    [newForm addSubview:loginView];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        loginView.frame = CGRectOffset(loginView.frame, 5, 25);
    }
    
    loginView.delegate = self;
    
    [newForm addSubview:loginView];
    
    [loginView sizeToFit];
}

-(void)tapScreen
{
//    [nameLabel resignFirstResponder];
    [userNameLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    [passwordLabel resignFirstResponder];

    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -150, 320, self.view.frame.size.height);
    }];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = [UIColor blackColor];
    textField.autocorrectionType = FALSE;
    textField.autocapitalizationType = FALSE;
    
    if ([textField.placeholder  isEqual: @" Enter email"]) {
        [UIView animateWithDuration:0.2 animations:^{
            newForm.frame = CGRectMake(0, -180, 320, self.view.frame.size.height);
        }];
    }else{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -140, 320, self.view.frame.size.height);
    }];
  }
    textField.placeholder = @"";

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Enter here";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)cancelLogin
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newUser{
    
    PFUser * user = [PFUser user];
    
//    user[@"First_Last"] = nameLabel.text;
    user.username = userNameLabel.text;
    user.password = passwordLabel.text;
    user.email = emailLabel.text;
//    user[@"avatar"] = imageFile;
    
//    nameLabel.text=nil;
    userNameLabel.text = nil;
    passwordLabel.text = nil;
    emailLabel.text = nil;
    
//    [nameLabel resignFirstResponder];
    [userNameLabel resignFirstResponder];
    [passwordLabel resignFirstResponder];
    [emailLabel resignFirstResponder];
    
    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 480);
    spinner.hidesWhenStopped = YES;
    [spinner setColor:[UIColor orangeColor]];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error == nil)
        {
            UINavigationController * pnc = (UINavigationController *)self.presentingViewController;
            
            pnc.navigationBarHidden = NO;
            pnc.viewControllers = @[[[MGMArtistsViewController alloc]initWithNibName:nil bundle:nil]];
            [self cancelLogin];
            
        }else{
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            [spinner removeFromSuperview];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"ERROR" message: errorDescription delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
        
        
    }];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePictureView.profileID = user.objectID;
    self.nameLabel.text = user.name;
    self.profilePic.profileID = user.objectID;
    self.loggedInUser = user;
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSString *alertMessage, *alertTitle;
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
}

- (void)makeRequestForUserLikes
{
    [FBRequestConnection startWithGraphPath:@"me?fields=music"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Success! Include your code to handle the results here
                                  //                                 NSLog(@"user likes: %@", result);
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  NSLog(@"error %@", error.description);
                              }
                              
                              NSMutableArray * artistList = [@[]mutableCopy];
                              
                              NSArray * data = result[@"music"][@"data"];
                              NSString * artist1 = data[0][@"name"];
                              [artistList addObject:artist1];
                              NSString * artist2 = data[1][@"name"];
                              [artistList addObject:artist2];
                              NSString * artist3 = data[2][@"name"];
                              [artistList addObject:artist3];
                              [MGMData mainData].likes = artistList;
                              NSLog(@"Music Likes %@", [MGMData mainData].likes);
                              //                              label1.text = [NSString stringWithFormat:@"%@",[MGMData mainData].likes[0]];
                              //                              label2.text = [NSString stringWithFormat:@"%@",[MGMData mainData].likes[1]];
                              //                              label3.text = [NSString stringWithFormat:@"%@",[MGMData mainData].likes[2]];
                          }];
}

- (void)requestLikes
{
    // We will request the user's events
    // These are the permissions we need:
    NSArray *permissionsNeeded = @[@"user_likes"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"me?fields=music"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
                                  NSLog(@"current permissions %@", currentPermissions);
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
                                  // Check if all the permissions we need are present in the user's current permissions
                                  // If they are not present add them to the permissions to be requested
                                  for (NSString *permission in permissionsNeeded){
                                      if (![currentPermissions objectForKey:permission]){
                                          [requestPermissions addObject:permission];
                                      }
                                  }
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession requestNewReadPermissions:requestPermissions
                                                                       completionHandler:^(FBSession *session, NSError *error) {
                                                                           if (!error) {
                                                                               // Permission granted
                                                                               NSLog(@"new permissions %@", [FBSession.activeSession permissions]);
                                                                               // We can request the user information
                                                                               [self makeRequestForUserLikes];
                                                                           } else {
                                                                               // An error occurred, we need to handle the error
                                                                               // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                                                               NSLog(@"error %@", error.description);
                                                                           }
                                                                       }];
                                  } else {
                                      // Permissions are present
                                      // We can request the user information
                                      [self makeRequestForUserLikes];
                                  }
                                  
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  NSLog(@"error %@", error.description);
                              }
                          }];
}
-(BOOL)prefersStatusBarHidden {return YES;}


@end
