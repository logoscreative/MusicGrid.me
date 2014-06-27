//
//  MGMCollectionViewController.m
//  MusicGrid
//
//  Created by Jonathan Fox on 6/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "MGMCollectionViewController.h"
#import "MGMTableViewCell.h"
#import "MGMTableView.h"

@interface MGMCollectionViewController ()

@end

@implementation MGMCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,568, 320)];
        background.image = [UIImage imageNamed:@"ios-members area"];
        background.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:background];
        
        self.view.backgroundColor = [UIColor clearColor];
        // Custom initialization
        UITableView * albumTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        albumTableView.transform = CGAffineTransformMakeRotation(90.0 * M_PI / 180); //Convert 90 degrees to radians
        albumTableView.dataSource = self;
        albumTableView.delegate = self;
        albumTableView.rowHeight = 200;
        albumTableView.backgroundColor = [UIColor clearColor];
        albumTableView.frame = CGRectMake(550 ,SCREEN_HEIGHT/2-100, SCREEN_WIDTH,200);
        
        albumTableView.SeparatorColor = [UIColor clearColor];
        albumTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:albumTableView];
        
        [UIView animateWithDuration:1.0 delay:0.0 options:
         UIViewAnimationOptionCurveEaseInOut animations:^{
             albumTableView.frame = CGRectMake(0 ,SCREEN_HEIGHT/2-100, SCREEN_WIDTH,200);
         } completion:^(BOOL finished) {
              }];
        
        self.albums = [@[
                         @"images1.jpg",
                         @"images2.jpg",
                         @"images3.jpg",
                         @"images4.jpg",
                         @"images5.jpg",
                         @"images6.jpg",
                         @"images7.jpg",
                         @"images8.jpg",
                         @"images9.jpg",
                         @"images10.jpg",
                         @"images11.jpg",
                         @"images12.jpg",
                         @"images13.jpg",
                         @"images14.jpg",
                         @"images15.jpg",
                         ]mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        MGMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[MGMTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.albumInfo = self.albums[indexPath.row];
    NSLog(@"%ld %@", (long)indexPath.row, cell.albumInfo);
        return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        [self.albums removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
//    [tableView reloadData];
}


-(BOOL)prefersStatusBarHidden {return YES;}

@end
