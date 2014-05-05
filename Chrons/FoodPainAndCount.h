//
//  FoodPainAndCount.h
//  Chrons
//
//  Created by Jesse Lifshitz on 5/1/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodPainAndCount : NSObject
@property (strong, nonatomic) NSString* food;
@property int count;
-(id)init;
-(id)initWith: (NSString*)newFood andCount: (int) newCount;
@end
