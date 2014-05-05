//
//  AppDelegate.h
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/5/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "SQLiteFunctions.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    sqlite3 *database;
    NSMutableArray *todos;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) SQLiteFunctions *sqlitefunc;
@end
