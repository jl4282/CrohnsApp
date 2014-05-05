//
//  family_history.h
//  Chrons
//
//  Created by Hannar Lee on 4/30/14.
//  Copyright (c) 2014 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface family_history : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) IBOutlet UIScrollView *_scroller;

@property (strong, nonatomic) IBOutlet UITextView *father_info;
@property (strong, nonatomic) IBOutlet UITextView *mother_info;
@property (strong, nonatomic) IBOutlet UITextView *other_info;

@end
