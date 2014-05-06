//
//  information.m
//  Chrons
//
//  Created by Hannar Lee on 5/1/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "information.h"

@interface information ()


@end

@implementation information

@synthesize text_view;



-(void) viewDidLoad
{
    self.tabBarController.title = @"Information";
    //[text_view setEditable:FALSE];
    
}

-(void) viewDidAppear:(BOOL)no{
    self.tabBarController.title = @"Information";
}

@end
