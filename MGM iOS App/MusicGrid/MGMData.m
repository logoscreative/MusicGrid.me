//
//  NAVData.m
//  Navigator
//
//  Created by Jonathan Fox on 5/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "MGMData.h"

@implementation MGMData

+(MGMData *)mainData
{
    static dispatch_once_t create;
    static MGMData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[MGMData alloc]init];
    });
    
    return singleton;
}

@end
