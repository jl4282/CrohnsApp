//
//  StringAndNumber.h
//  Chrons
//
//  Created by Jesse Lifshitz on 5/2/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringAndNumber : NSObject
@property (strong, nonatomic) NSString* string;
@property int number;
-(id)init;
-(id)initWith: (NSString*)newString andNumber: (int) newNumber;
@end
