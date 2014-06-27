//
//  MGMArtistsViewController.m
//  MusicGrid
//
//  Created by Jonathan Fox on 6/8/14.
//  Copyright (c) 2014 Ed Salter. All rights reserved.
//

#import "MGMArtistsViewController.h"
#import "MGMCollectionViewController.h"

@interface MGMArtistsViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UILabel *labelFirstName;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *statusLabel;
@end

@implementation MGMArtistsViewController
{
    UITextField * artist1;
    UITextField * artist2;
    UITextField * artist3;
    UIActivityIndicatorView * spinner;
    UIView *newForm;
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
    
    UIImageView * textBox1 = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-200), 100, 400, 40)];
    textBox1.image = [UIImage imageNamed:@"password_area"];
    [newForm addSubview:textBox1];
    
    UIImageView * textBox2 = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-200), 150, 400, 40)];
    textBox2.image = [UIImage imageNamed:@"password_area"];
    [newForm addSubview:textBox2];
    
    UIImageView * textBox3 = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-200), 200, 400, 40)];
    textBox3.image = [UIImage imageNamed:@"password_area"];
    [newForm addSubview:textBox3];
    
    artist1 = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-190), 100, 400, 40)];
    artist1.backgroundColor = [UIColor clearColor];
    artist1.layer.cornerRadius = 4;
    artist1.delegate = self;
    artist1.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    artist1.leftViewMode = UITextFieldViewModeAlways;
    artist1.placeholder = @" Artist 1";
    [artist1 setTextColor:[UIColor whiteColor]];
    
    artist1.delegate = self;
    
    [newForm addSubview:artist1];
    
    artist2 = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-190), 150, 200, 40)];
    artist2.backgroundColor = [UIColor clearColor];
    artist2.layer.cornerRadius = 4;
    artist2.delegate = self;
    artist2.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    artist2.leftViewMode = UITextFieldViewModeAlways;
    artist2.placeholder = @" Artist 2";
    artist2.textColor = [UIColor whiteColor];
    
    artist2.delegate = self;
    
    [newForm addSubview:artist2];
    
    artist3 = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-190), 200, 200, 40)];
    artist3.backgroundColor = [UIColor clearColor];
    artist3.layer.cornerRadius = 4;
    artist3.delegate = self;
    artist3.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    artist3.leftViewMode = UITextFieldViewModeAlways;
    artist3.placeholder = @" Artist 3";
    artist3.textColor = [UIColor whiteColor];
    
    artist3.delegate = self;
    
    [newForm addSubview:artist3];

    
    
    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2-55), 250, 110, 45)];
    [submitButton setTitle:@"SUBMIT" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(openCollectionVC) forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor = [UIColor colorWithRed:0.016f green:0.863f blue:0.529f alpha:1.0f];
    submitButton.layer.cornerRadius = 4;
    [newForm addSubview:submitButton];
    
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelLogin)];
    
    cancelButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

-(void)openCollectionVC
{
    MGMCollectionViewController *cvc = [[MGMCollectionViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:cvc animated:YES];
}

-(void)tapScreen
{
    //    [nameLabel resignFirstResponder];
    [artist1 resignFirstResponder];
    [artist3 resignFirstResponder];
    [artist2 resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -200, 320, self.view.frame.size.height);
    }];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = [UIColor blackColor];
    textField.autocorrectionType = FALSE;
    textField.autocapitalizationType = FALSE;
    
    if ([textField.placeholder  isEqual: @" Artist 3"]) {
        [UIView animateWithDuration:0.2 animations:^{
            newForm.frame = CGRectMake(0, -90, 320, self.view.frame.size.height);
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            newForm.frame = CGRectMake(0, -70, 320, self.view.frame.size.height);
        }];
    }
    textField.placeholder = @"";
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.placeholder = @"Enter Artist here";
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

-(BOOL)prefersStatusBarHidden {return YES;}


@end
