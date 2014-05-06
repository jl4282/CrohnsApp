//
//  email_to_doc.m
//  Chrons
//
//  Created by Hannar Lee on 4/29/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import "email_to_doc.h"

@interface email_to_doc ()


@end


@implementation email_to_doc

@synthesize dname_tf;
@synthesize demail_tf;
@synthesize dnote_tf;

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
    dnote_tf.layer.cornerRadius = 5;
    dnote_tf.layer.borderWidth = 0.5f;
    dnote_tf.layer.borderColor = [[UIColor grayColor] CGColor];
 
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyBoard)];
    
    
    [self.view addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)dismissKeyBoard{
    

    [demail_tf resignFirstResponder];
    [dname_tf resignFirstResponder];
    [dnote_tf resignFirstResponder];
    
}


- (IBAction)sendEmail:(id)sender {
   
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
