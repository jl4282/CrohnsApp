//
//  information.h
//  Chrons
//
//  Created by Hannar Lee on 5/1/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteFunctions.h"
#import "FoodPainAndCount.h"
#import "StringAndNumber.h"

@interface information : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextView *text_view;


@end