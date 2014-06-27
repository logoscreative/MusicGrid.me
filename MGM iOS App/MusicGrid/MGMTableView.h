//
//  MGMTableView.h
//  Music Grid
//
//  Created by Jonathan Fox on 5/30/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "MGMCollectionViewController.h"

@protocol TableViewProtocol <NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MGMTableView : MGMCollectionViewController

@end
