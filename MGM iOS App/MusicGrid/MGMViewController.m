//
//  MGMViewController.m
//  MusicGrid
//
//  Created by Jonathan Fox on 6/6/14.
//  Copyright (c) 2014 Jonathan Fox. All rights reserved.
//

#import "MGMViewController.h"
#import "MGMData.h"
#import "MGMCollectionViewController.h"
#import "MGMSignUpVC.h"
#import "MGMLogInVC.h"

@interface MGMViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) FBProfilePictureView *profilePic;

@property (strong, nonatomic) UILabel *labelFirstName;
@property (strong, nonatomic)  FBProfilePictureView *profilePictureView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *statusLabel;

@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation MGMViewController
{
    UILabel * label1;
    UILabel * label2;
    UILabel * label3;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,568, 320)];
        background.image = [UIImage imageNamed:@"iphone-layout"];
        background.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:background];
        
        UIImageView * pulse = [[UIImageView alloc]initWithFrame:CGRectMake(300, 100,175, 100)];
        pulse.image = [UIImage imageNamed:@"logo_color"];
        pulse.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:pulse];
        
        UIImageView * appStore = [[UIImageView alloc]initWithFrame:CGRectMake(375, 180,100, 50)];
        appStore.image = [UIImage imageNamed:@"app_store_button"];
        appStore.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:appStore];
        
        UILabel * intro = [[UILabel alloc]initWithFrame:CGRectMake(300, 20, 250, 100)];
        intro.text = @"welcome to";
        intro.font = [UIFont fontWithName:@"HelveticaNeue-Ultralight" size:45];
        intro.textColor = [UIColor whiteColor];
        [self.view addSubview:intro];

        
        UIButton * logIn = [[UIButton alloc]initWithFrame:CGRectMake(10, -5, 70, 40)];
        logIn.backgroundColor = [UIColor clearColor];
        logIn.titleLabel.textAlignment = 1;
        [logIn setBackgroundImage:[UIImage imageNamed:@"sign_up_button"] forState:UIControlStateNormal];
        logIn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:10];
        [logIn setTitle:@"" forState:UIControlStateNormal];
        
        [logIn addTarget:self action:@selector(openLoginPage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logIn];
    }
    return self;
}

-(void)openLoginPage
{
    MGMLogInVC *svc = [[MGMLogInVC alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];
}

-(void)openCollectionView
{
    MGMCollectionViewController *cvc = [[MGMCollectionViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends", @"user_likes"]];
    
    loginView.frame = CGRectMake(self.view.center.x - (loginView.frame.size.width / 2), self.view.frame.size.height/2+100, loginView.frame.size.width, loginView.frame.size.height);
    [self.view addSubview:loginView];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        loginView.frame = CGRectOffset(loginView.frame, 5, 25);
    }

    loginView.delegate = self;
    
    [self.view addSubview:loginView];
    
    [loginView sizeToFit];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
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
                              label1.text = [NSString stringWithFormat:@"%@",[MGMData mainData].likes[0]];
                              label2.text = [NSString stringWithFormat:@"%@",[MGMData mainData].likes[1]];
                              label3.text = [NSString stringWithFormat:@"%@",[MGMData mainData].likes[2]];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {return YES;}


@end
