//
//  PB-SOSPOPSecondViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface PB_SOSPOPSecondViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telepN1;
@property (weak, nonatomic) IBOutlet UITextField *telepN2;
@property (weak, nonatomic) IBOutlet UITextField *bloodVolume;

- (IBAction)backVC:(UIBarButtonItem *)sender;



- (IBAction)nextStep:(UIButton *)sender;

- (IBAction)recoverKeyboard:(UIControl *)sender;

- (IBAction)popVC:(UIButton *)sender;


@end
