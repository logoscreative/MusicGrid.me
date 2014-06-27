//
//  MGMCollectionViewController.h
//  MusicGrid
//
//  Created by Jonathan Fox on 6/7/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MGMCollectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray * albums;

@end
