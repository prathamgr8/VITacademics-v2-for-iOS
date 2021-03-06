//
//  ShareViewController.h
//  VITacademics
//
//  Created by Siddharth on 02/02/14.
//  Copyright (c) 2014 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)addWithPINpressed:(id)sender;
- (IBAction)addManuallyPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *token;
@property (weak, nonatomic) IBOutlet UILabel *subtitle1;
@property (weak, nonatomic) IBOutlet UILabel *tokenValidity;
@property (weak, nonatomic) IBOutlet UILabel *subtitle2;
@property (weak, nonatomic) IBOutlet UILabel *subtitle3;

@end
