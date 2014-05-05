//
//  email_to_doc.h
//  Chrons
//
//  Created by Hannar Lee on 4/29/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface email_to_doc : UIViewController  <MFMailComposeViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *dname_tf;
@property (weak, nonatomic) IBOutlet UITextField *demail_tf;


- (IBAction)sendEmail:(id)sender;

@end
