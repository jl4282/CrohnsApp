//
//  BM.m
//  Chrons
//
//  Created by Hannar Lee on 5/2/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "BM.h"
#import "SQLiteFunctions.h"

@interface BM ()

@end
// haha hihi
@implementation BM

NSString* _storing_time_data;
NSDate* _storing_date_data;


@synthesize _time_button;
@synthesize _log_button;
@synthesize _date_picker;
@synthesize _complete_button;
@synthesize _blood;
@synthesize _color_tf;
@synthesize _constipation;
@synthesize _description;
@synthesize _diarrhea;
@synthesize _scroll;
@synthesize _size_tf;
@synthesize _urgency;
@synthesize sqlitefunc;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    _description.layer.cornerRadius = 5;
    _description.layer.borderWidth = 0.5f;
    _description.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [super viewDidLoad];
    [super viewDidLoad];
    [self._scroll setScrollEnabled:YES];
    [self._scroll setContentSize:(CGSizeMake(320, 800))];
    
    self._scroll.center = CGPointMake(160, 250);
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    
    
    [self.view addGestureRecognizer:tap];
    
    _complete_button.hidden = true;
    _date_picker.hidden = true;

}



-(void)dismissKeyBoard{
    
    [_description resignFirstResponder];
    [_color_tf resignFirstResponder];
    [_size_tf resignFirstResponder];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView: (UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 0) // click yes (need to modify to SQL)
    {
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSString* formattedDateString = [dateFormat stringFromDate:date];
        
        sqlitefunc = [[SQLiteFunctions alloc]init];
        
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateFormat:@"HH:mm"];
        
        NSString* time_format = [dateFormatter stringFromDate:_storing_date_data];
        
        formattedDateString = [NSString stringWithFormat:@"%@ %@",formattedDateString,time_format];
        
        [sqlitefunc insertIntoBM:formattedDateString andSize:_size_tf.text andColor:_color_tf.text andBlood:_blood.on andUrgency:_urgency.on andDescription:_description.text andConstipation:_constipation.on andDiarrhea:_diarrhea.on];
        
        
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)time_touched:(id)sender {
    
    [self dismissKeyBoard];
    [_scroll    setScrollEnabled:FALSE];
    _complete_button.hidden = false;
    _date_picker.hidden = false;
    _log_button.hidden = true;
    _description.hidden = true;
}

- (IBAction)complete_touched:(id)sender {
    
    [_scroll setScrollEnabled:TRUE];
    _complete_button.hidden = true;
    _date_picker.hidden = true;
    _log_button.hidden = false;
    _description.hidden = false;
    
    
    NSDate* chosen = [_date_picker date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSString* formattedDateString = [dateFormatter stringFromDate:chosen];
    
    _time_button.titleLabel.text = formattedDateString;
    
    _storing_time_data = [NSString stringWithFormat: formattedDateString];
    
    _storing_date_data = chosen;
    
    
}

-(void)textFieldDidBeginEditing: (UITextField *)textField{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y - 50);
    [_scroll setContentOffset:scrollPoint animated:YES];
    
}


-(void)textFieldDidEndEditing:(UITextField *) textField{
    [_scroll setContentOffset:CGPointZero animated: YES];
}

-(void)textViewDidBeginEditing:(UITextView*)textView
{
    CGPoint scrollPoint = CGPointMake(0, textView.frame.origin.y - 110);
    
    [_scroll setContentOffset:scrollPoint animated:YES];
    
}

-(void)textViewDidEndEditing:(UITextView*) textView
{
    [textView resignFirstResponder];
    
}


- (IBAction)log_touched:(id)sender {
    
    NSLog(@"Button Pressed");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is this the correct information?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Cancel", nil];
    
    [alert show];
    
    

}
@end
