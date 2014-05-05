//
//  pain.h
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/11/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteFunctions.h"

@interface pain : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *severity;
@property (strong, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) IBOutlet UIButton *_time_button;

@property (strong, nonatomic) IBOutlet UITextField *location_tf;

@property (strong, nonatomic) IBOutlet UIDatePicker *_date_picker;
@property (strong, nonatomic) IBOutlet UIButton *_complete_button;

@property (strong, nonatomic) IBOutlet UIScrollView *_scroller;

@property (strong, nonatomic) IBOutlet UIButton *_log_button;

- (IBAction)log:(id)sender;
- (IBAction)complete_pressed:(id)sender;
- (IBAction)time_pressed:(id)sender;


@property (nonatomic,strong) SQLiteFunctions *sqlitefunc; //updated brandon

@end
