//
//  settings.h
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/23/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settings : UIViewController < UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIScrollView *_scroller;
@property (strong, nonatomic) IBOutlet UIPickerView *_picker;

@property (strong, nonatomic) IBOutlet UIButton *smoking_button;
@property (strong, nonatomic) IBOutlet UIButton *complete_button;
@property (strong, nonatomic) IBOutlet UIButton *alcohol_button;

@property (strong, nonatomic) IBOutlet UIButton *DOB_button;
@property (strong, nonatomic) IBOutlet UIButton *diagnosed_button;

@property (strong, nonatomic) IBOutlet UITextField *name_tf;

- (IBAction)DOB_pressed:(id)sender;
- (IBAction)diagnosed_pressed:(id)sender;
- (IBAction)smoking_pressed:(id)sender;
- (IBAction)alcohol_pressed:(id)sender;
- (IBAction)complete_pressed:(id)sender;

@end
