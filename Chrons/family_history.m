//
//  family_history.m
//  Chrons
//
//  Created by Hannar Lee on 4/30/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "family_history.h"

@interface family_history ()

@end


@implementation family_history

CGSize pageSize;

@synthesize title_label;
@synthesize _scroller;

@synthesize father_info;
@synthesize mother_info;
@synthesize other_info;



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
    father_info.layer.cornerRadius = 5;
    father_info.layer.borderWidth = 0.5f;
    father_info.layer.borderColor = [[UIColor grayColor] CGColor];
    mother_info.layer.cornerRadius = 5;
    mother_info.layer.borderWidth = 0.5f;
    mother_info.layer.borderColor = [[UIColor grayColor] CGColor];
    other_info.layer.cornerRadius = 5;
    other_info.layer.borderWidth = 0.5f;
    other_info.layer.borderColor = [[UIColor grayColor] CGColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    title_label.text = @"Family medication background\n Hit Back When finished";
    //self.mother_info
    
    [self._scroller setScrollEnabled:YES];
    
    [self._scroller setContentSize:(CGSizeMake(320, 800))];
    
    self._scroller.center = CGPointMake(160, 270);
    
    self.father_info.delegate = self;
    self.mother_info.delegate = self;
    self.other_info.delegate = self;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView*)textView
{
    CGPoint scrollPoint = CGPointMake(0, textView.frame.origin.y - 110);
    
    [_scroller setContentOffset:scrollPoint animated:YES];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    pageSize = CGSizeMake(850, 1100);
    NSString *filename = @"personal_information2.pdf";
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pdf_location = [docPath stringByAppendingString:filename];
    
    NSLog(pdf_location);
    
    [self generatePdf:pdf_location];

    
}

-(void)generatePdf:(NSString*)filePath
{
  

    
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 100, 850, 1100), nil);
    
    [self createInfo];
    
    UIGraphicsEndPDFContext();
}

-(void) createInfo
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect textRect = CGRectMake(0, 0, 850 , 500);
    
    NSString *infoString = [NSString stringWithFormat:@"Father:\n %@ \n\n Mother:\n %@ \n\n Other:\n%@ ",father_info.text, mother_info.text, other_info.text];
                            
                            
    
    [infoString drawInRect:textRect withAttributes:nil];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [father_info resignFirstResponder];
    [mother_info resignFirstResponder];
    [other_info resignFirstResponder];
    

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

@end
