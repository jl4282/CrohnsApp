//
//  meal.h
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/16/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteFunctions.h"

@interface meal : UIViewController

- (IBAction)log_button:(id)sender;
- (IBAction)time_pressed:(id)sender;
- (IBAction)complete_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *_food;
@property (strong, nonatomic) IBOutlet UITextField *_prepared;
@property (strong, nonatomic) IBOutlet UITextField *_size;
@property (strong, nonatomic) IBOutlet UITextField *_drinks;
@property (strong, nonatomic) IBOutlet UITextField *_sauces;
@property (strong, nonatomic) IBOutlet UITextField *_spices;
@property (strong, nonatomic) IBOutlet UIScrollView *myscroller;
@property (strong, nonatomic) IBOutlet UIButton *__log_button;

@property (strong, nonatomic) IBOutlet UIButton *_time_button;
@property (strong, nonatomic) IBOutlet UIButton *_complete_button;
@property (strong, nonatomic) IBOutlet UIDatePicker *_date_picker;



@property (strong, nonatomic) IBOutlet UITextView *_description;

@property (nonatomic,strong) SQLiteFunctions *sqlitefunc; //updated brandon



@end
