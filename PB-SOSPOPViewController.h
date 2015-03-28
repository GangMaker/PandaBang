//
//  PB-SOSPOPViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PB_SOSPOPViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *textName;

@property (weak, nonatomic) IBOutlet UITextField *textAge;

- (IBAction)backVC:(UIBarButtonItem *)sender;

- (IBAction)chooseBlood:(UIButton *)sender;
- (IBAction)chooseLocation:(UIButton *)sender;


- (IBAction)nextStepAction:(UIButton *)sender;



@end
