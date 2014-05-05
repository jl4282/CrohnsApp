//
//  StringAndNumber.m
//  Chrons
//
//  Created by Jesse Lifshitz on 5/2/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "StringAndNumber.h"

@implementation StringAndNumber
@synthesize string;
@synthesize number;

-(id)init{
    return[self initWith: @"This doesn't Work" andNumber:1];
}

-(id)initWith: (NSString*)newString andNumber: (int) newNumber{
    self.string = newString;
    self.number = newNumber;
    return self;
}
@end
