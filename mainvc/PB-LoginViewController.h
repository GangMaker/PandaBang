//
//  PB-LoginViewController.h
//  PANDA-BANG
//
//  Created by mhand on 15/2/15.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PB_LoginViewController : UIViewController
- (IBAction)dissmissVC:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *UserPhoneNameTF;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTF;

@end
