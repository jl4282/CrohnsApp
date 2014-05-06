//
//  settings.m
//  Chrons
//
//  Created by Kwang-Jae Chang on 4/23/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "settings.h"
@interface settings()
{
    CGSize pageSize;
}
@property (strong, nonatomic) NSArray* smoking_array;
@property (strong, nonatomic) NSArray* drinking_array;

    


@end


@implementation settings

int picker_index;
float picker_coor_y;
float complete_button_y;

bool DOB_chosen;


NSMutableArray* day_array;
NSMutableArray* year_array;
NSArray* month_array;




@synthesize _scroller;
@synthesize _picker;
@synthesize smoking_button;
@synthesize complete_button;
@synthesize smoking_array;
@synthesize drinking_array;
@synthesize alcohol_button;
@synthesize name_tf;
@synthesize DOB_button;
@synthesize diagnosed_button;



-(void) viewDidLoad{
    
    
    
    

    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    
    
    [self.view addGestureRecognizer:tap];
    [self._scroller setScrollEnabled:YES];
    
    [self._scroller setContentSize:(CGSizeMake(320, 800))];
    
    self._scroller.center = CGPointMake(160, 250);
    
    picker_coor_y = _picker.center.y;
    complete_button_y = complete_button.center.y;
    
    
    complete_button.hidden = TRUE;
    
    smoking_array = [[NSArray alloc] initWithObjects:@"None",@"< half a pack", @"Half a pack", @"1 pack", @"1~2 packs", @"more than 2 packs", nil];
    
    drinking_array = [[NSArray alloc] initWithObjects:@"None", @"1~3 per week", @"3~5 per week", @"More than 5 per week", nil];

    
    day_array = [[NSMutableArray alloc] init];
    
    for(int i = 1; i <= 31 ; i++)
    {
        [day_array addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    month_array = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy"];
    NSString *yearString = [dateFormat stringFromDate:today];
    
    int temp;
    
    year_array = [[NSMutableArray alloc] init];
    
    for(int i =0; i < 100; i++)
    {
        temp = [yearString intValue] - i;
        [year_array addObject: [NSString stringWithFormat:@"%d",temp]];
        
    }
    
    
    
    _picker.hidden = TRUE;
    
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    
    pageSize = CGSizeMake(850, 1100);
    NSString *filename = @"personal_information.pdf";
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pdf_location = [docPath stringByAppendingString:filename];
    
    NSLog(pdf_location);
    
    [self generatePdf:pdf_location];

    
}

-(void)generatePdf:(NSString*)filePath
{
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 850, 1100), nil);
    
    [self drawBackground];
    [self createInfo];
    
    UIGraphicsEndPDFContext();
}

-(void)drawBackground
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, pageSize.width, pageSize.height);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextFillRect(context, rect);
    
}

-(void) createInfo
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect textRect = CGRectMake(0, 0, 850 , 1100);
    
    NSString *infoString = [NSString stringWithFormat:@"Date Diagnosed: %@ \nName: %@            DOB:%@ \n Alcohol: %@ \n Smoking: %@",diagnosed_button.titleLabel.text, name_tf.text, DOB_button.titleLabel.text, alcohol_button.titleLabel.text, smoking_button.titleLabel.text] ;
    
    [infoString drawInRect:textRect withAttributes:nil];
    
    
}
-(void) _button_pushed
{
    [self dismissKeyBoard];
    [_scroller setScrollEnabled:false];
    
}

-(void)dismissKeyBoard{
    
    [name_tf resignFirstResponder];
    
}

- (IBAction)DOB_pressed:(id)sender {
    
    [self _button_pushed];
    DOB_chosen = true;
    picker_index = 1;
    [_picker reloadAllComponents];
    
    
    _picker.hidden = false;
    
    _picker.center = CGPointMake(_picker.center.x, picker_coor_y - 50);
    
    complete_button.center = CGPointMake(complete_button.center.x, complete_button_y - 50);
    
    complete_button.hidden = false;
    
    
}

- (IBAction)diagnosed_pressed:(id)sender {
    
    [self _button_pushed];
    DOB_chosen = false;
    picker_index = 1;
    [_picker reloadAllComponents];
    
    _picker.hidden = false;
    
    _picker.center = CGPointMake(_picker.center.x, picker_coor_y - 50);
    
    complete_button.center = CGPointMake(complete_button.center.x, complete_button_y - 50);
    
    complete_button.hidden = false;
    
}

- (IBAction)smoking_pressed:(id)sender {
    
    [self _button_pushed];
    CGPoint scrollPoint = CGPointMake(0, smoking_button.frame.origin.y - 100);
    
    [_scroller setContentOffset: scrollPoint animated: YES];
    
    picker_index = 3;
    [_picker reloadAllComponents];
    
    
    _picker.center = CGPointMake(_picker.center.x, picker_coor_y);
    
    complete_button.center = CGPointMake(complete_button.center.x, complete_button_y);
    
    
    _picker.hidden = false;
    complete_button.hidden = false;
    
    
}


- (IBAction)alcohol_pressed:(id)sender {
    
    [self _button_pushed];
    CGPoint scrollPoint = CGPointMake(0, alcohol_button.frame.origin.y - 100);
    
    [_scroller setContentOffset: scrollPoint animated: YES];
    
    picker_index = 2;
    [_picker reloadAllComponents];
    
    
    _picker.center = CGPointMake(_picker.center.x, picker_coor_y );
    complete_button.center = CGPointMake(complete_button.center.x, complete_button_y);
    
    
    _picker.hidden = false;
    complete_button.hidden = false;
}

- (IBAction)complete_pressed:(id)sender {
    
    [_scroller setScrollEnabled:TRUE];
    _picker.hidden = true;
    complete_button.hidden = true;
    NSString* _select;
    
    NSString* day_select;
    NSString* month_select;
    NSString* year_select;
    
    if(picker_index == 3)
    {
        _select = [smoking_array objectAtIndex:[_picker selectedRowInComponent:0]];
        
        [smoking_button setTitle:_select forState:UIControlStateNormal];
         
        
    }
    else if (picker_index == 2)
    {
        _select = [drinking_array objectAtIndex: [_picker selectedRowInComponent:0]];
        
        if([_picker selectedRowInComponent:0] == [drinking_array count] - 1)
        {
            [alcohol_button setTitle:@"> 5 drinks per week" forState:UIControlStateNormal];
            
        }
        else
        [alcohol_button setTitle:_select forState:UIControlStateNormal];
        
    }
    
    else
    {
        
        month_select = [month_array objectAtIndex:[_picker selectedRowInComponent:0]];
        day_select = [day_array objectAtIndex:[_picker selectedRowInComponent:1]];
        year_select = [year_array objectAtIndex:[_picker selectedRowInComponent:2]];
        
        
        _select = [NSString stringWithFormat:@"%@/%@/%@",month_select,day_select,year_select];
        
        if(DOB_chosen == true)
        {
            [DOB_button setTitle:_select forState:UIControlStateNormal];
            
        }
        
        else
        {
            [diagnosed_button setTitle:_select forState:UIControlStateNormal];
        }
        
        
        
        
        
    }
    CGPoint scrollPoint = CGPointMake(0, -70);
    [_scroller setContentOffset:scrollPoint animated:YES];
    
    
    
    
}




#pragma mark Picker Data Source Methods

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
        if(picker_index == 1)
        {
            return 3;
        }
        else
        return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(picker_index == 3)
    return [smoking_array count]; //returns the number of rows in each component
    else if(picker_index == 2)
        return [drinking_array count];
    else
    {
            if(component == 0)
                return [month_array count];
            else if(component == 1)
                return [day_array count];
            else
                return [year_array count];
        
    }
}

#pragma mark Picker Delegate Methods

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(picker_index == 3)
    return [smoking_array objectAtIndex:row];
    else if(picker_index ==2)
        return [drinking_array objectAtIndex:row];
    else
    {
        if(component == 0)
            return [month_array objectAtIndex:row];
        else if(component ==1)
            return [day_array objectAtIndex:row];
        else
            return [year_array objectAtIndex:row];
    }
}


@end
