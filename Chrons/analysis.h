//
//  analysis.h
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/11/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteFunctions.h"
#import "FoodPainAndCount.h"
#import "StringAndNumber.h"


@interface analysis : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *mainTable;
    NSMutableArray *dataArray;
}
@property (strong, nonatomic) IBOutlet UITextView *report;
@property (nonatomic, strong) SQLiteFunctions *sqlitefunc;


@end
