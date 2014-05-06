//
//  meal.m
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/16/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "meal.h"

@implementation meal

NSDate* _storing_chosen_date;

@synthesize _food;
@synthesize _prepared;
@synthesize _size;
@synthesize _sauces;
@synthesize _drinks;
@synthesize _spices;
@synthesize _description;
@synthesize sqlitefunc;

@synthesize myscroller;

@synthesize _time_button;
@synthesize _complete_button;
@synthesize _date_picker;
@synthesize __log_button;



-(void) viewDidLoad
{
    [super viewDidLoad];
    [self.myscroller setScrollEnabled:YES];
    [self.myscroller setContentSize:(CGSizeMake(320, 800))];
    _description.layer.cornerRadius = 5;
    _description.layer.borderWidth = 0.5f;
    _description.layer.borderColor = [[UIColor grayColor] CGColor];
    self.myscroller.center = CGPointMake(160, 250);
  
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    
    
    [self.view addGestureRecognizer:tap];
    
    _complete_button.hidden = true;
    _date_picker.hidden = true;

                                         
    
}

- (IBAction)log_button:(id)sender {
    
    
    NSLog(@"Button Pressed");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is this the correct information?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"cancel", nil];
    
    [alert show];
    
    
    
}

- (IBAction)time_pressed:(id)sender {
    
    [myscroller setScrollEnabled:FALSE];
    _complete_button.hidden = false;
    _date_picker.hidden = false;
    __log_button.hidden = true;
    _description.hidden = true;
    
    
}

- (IBAction)complete_pressed:(id)sender {
    
    [myscroller setScrollEnabled:TRUE];
    _complete_button.hidden = true;
    _date_picker.hidden = true;
    __log_button.hidden = false;
    _description.hidden = false;
    

    NSDate* chosen = [_date_picker date];
    _storing_chosen_date = chosen;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSString* formattedDateString = [dateFormatter stringFromDate:chosen];
    
    _time_button.titleLabel.text = formattedDateString;
    
    
    
}




-(void)alertView: (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0) // click yes (need to modify to SQL)
    {
    
        NSDate *date = [NSDate date];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSString* formattedDateString = [dateFormat stringFromDate:date];
        
        int len = [self._food.text length];
        NSMutableString *tempString= [NSMutableString stringWithCapacity:1000];
        NSMutableArray *arrayOfFood = [[NSMutableArray alloc] init];
        int counter = 0;
        for (int i = 0;i < len;i++)
        {
            unichar ch = [self._food.text characterAtIndex:i];
            if (ch == ' ')
            {
                counter++;
                [arrayOfFood addObject:tempString];
                // NSLog(@"%@",arrayOfFood);
                tempString  = [[NSMutableString alloc]init];
                [tempString setString:@""];
            }
            else {
                if ((ch != ',')||(ch != '.'))
                {
                    [tempString appendString:[NSString stringWithCharacters:&ch length:1]];
                }
            }
        }
        //tempString = @"F";
        //NSLog(@"array: %@", arrayOfFood);
        //NSLog(@"tempstring : %@",tempString);
        /* for (NSString *yourvar in arrayOfFood)
         {
         NSLog (@"Your Array elements are = %@", yourvar);
         }*/
        if ([tempString length] != 0)
        {
            [arrayOfFood addObject:tempString];
        }
        
        
        sqlitefunc  = [[SQLiteFunctions alloc]init];
      
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        
        NSString* time_format= [dateFormatter stringFromDate:_storing_chosen_date];
        
        
        
        formattedDateString = [NSString stringWithFormat:@"%@ %@",formattedDateString,time_format];
        
        
        [sqlitefunc aggregateDataForMeal:arrayOfFood andTime:formattedDateString andSauce:_sauces.text andDrinks:_drinks.text andDescription:_description.text andSpices:_spices.text andSize:_size.text andCooked:_prepared.text];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }
    
    
    
}



-(void)dismissKeyBoard{
    
    [_food resignFirstResponder];
    [_prepared resignFirstResponder];
    [_size resignFirstResponder];
    [_drinks resignFirstResponder];
    [_sauces resignFirstResponder];
    [_spices resignFirstResponder];
    [_description resignFirstResponder];
    
    
}


-(void)textFieldDidBeginEditing: (UITextField *)textField{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y - 50);
    [myscroller setContentOffset:scrollPoint animated:YES];
    
}


-(void)textFieldDidEndEditing:(UITextField *) textField{
    [myscroller setContentOffset:CGPointZero animated: YES];
}

-(void)textViewDidBeginEditing:(UITextView*)textView
{
    CGPoint scrollPoint = CGPointMake(0, textView.frame.origin.y - 110);
    
    [myscroller setContentOffset:scrollPoint animated:YES];
    
}

-(void)textViewDidEndEditing:(UITextView*) textView
{
    [textView resignFirstResponder];
    
}

@end
