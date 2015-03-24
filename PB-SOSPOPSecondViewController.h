//
//  PB-SOSPOPSecondViewController.h
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface PB_SOSPOPSecondViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (assign, nonatomic)int error;

- (IBAction)publishS:(UIBarButtonItem *)sender;

- (IBAction)recoverKeyboard:(UIControl *)sender;


@end
