//
//  pain.m
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/11/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "pain.h"

@implementation pain

NSString* _storing_time_data;
NSDate* _storing_date_data;

@synthesize severity;
@synthesize description;
@synthesize location_tf;

@synthesize _time_button;
@synthesize _date_picker;
@synthesize _complete_button;
@synthesize _scroller;
@synthesize _log_button;

@synthesize sqlitefunc;

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    description.layer.cornerRadius = 5;
    
    
    [self._scroller setScrollEnabled:YES];
    [self._scroller setContentSize:(CGSizeMake(320,500))];
    
    self._scroller.center = CGPointMake(160,230);
    
    
    description.layer.cornerRadius = 5;
    description.layer.borderWidth = 0.5f;
    description.layer.borderColor = [[UIColor grayColor] CGColor];
    

        
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
    [self._scroller addGestureRecognizer:tap];
    _complete_button.hidden = true;
    _date_picker.hidden = true;
    
    
}


-(void)dismissKeyBoard
{
    [severity resignFirstResponder];
    [description resignFirstResponder];
    [location_tf resignFirstResponder];
    
}

- (IBAction)log:(id)sender {
    
    NSLog(@"Button Pressed");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is this the correct information?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    
    [alert show];
    
    
}

- (IBAction)complete_pressed:(id)sender {
    [_scroller setScrollEnabled:true];
    _complete_button.hidden = true;
    _date_picker.hidden = true;
    _log_button.hidden = false;
    description.hidden = false;
    
    NSDate* chosen = [_date_picker date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSString* formattedDateString = [dateFormatter stringFromDate:chosen];
    
    _time_button.titleLabel.text = formattedDateString;
    
    _storing_time_data = [NSString stringWithFormat: formattedDateString];
    
    _storing_date_data = chosen;
    
}

- (IBAction)time_pressed:(id)sender {
    
    [self dismissKeyBoard];
    [_scroller setScrollEnabled:false];
    _complete_button.hidden = false;
    _date_picker.hidden = false;
    _log_button.hidden = true;
    description.hidden = true;
    
}


-(void)alertView: (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0)
    {
        
        
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSString* formattedDateString = [dateFormat stringFromDate:date];
        
        
        sqlitefunc  = [[SQLiteFunctions alloc]init];
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        
        NSString* time_format= [dateFormatter stringFromDate:_storing_date_data];
        
        int sever_rating_int = [severity.text intValue];
        
        
        formattedDateString = [NSString stringWithFormat:@"%@ %@",formattedDateString,time_format];
        
        
        [sqlitefunc insertIntoPain:formattedDateString andPainRating:sever_rating_int andLocation:location_tf.text andDescription:description.text];
        
        
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];

        
        
        
    }
}


-(void)textFieldDidBeginEditing: (UITextField *)textField{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y - 50);
    [_scroller setContentOffset:scrollPoint animated:YES];
    
}


-(void)textFieldDidEndEditing:(UITextField *) textField{
    [_scroller setContentOffset:CGPointZero animated: YES];
}

-(void)textViewDidBeginEditing:(UITextView*)textView
{
    CGPoint scrollPoint = CGPointMake(0, textView.frame.origin.y - 50);
    
    [_scroller setContentOffset:scrollPoint animated:YES];
    
}

-(void)textViewDidEndEditing:(UITextView*) textView
{
    [textView resignFirstResponder];
    
}



@end
