//
//  MGMTableViewCell.m
//  Music Grid
//
//  Created by Jonathan Fox on 6/6/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "MGMTableViewCell.h"

@implementation MGMTableViewCell
{
    UIImageView *albumImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 190, 190)];
        albumImageView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        albumImageView.transform = CGAffineTransformMakeRotation(90.0 * M_PI / -180); //Convert 90 degrees to radians

        
        [self.contentView addSubview:albumImageView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setAlbumInfo:(NSString *)albumInfo
{
    _albumInfo = albumInfo;
    UIImage * currentAlbum = [UIImage imageNamed:albumInfo];
    albumImageView.image = currentAlbum;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
