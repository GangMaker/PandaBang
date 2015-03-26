//
//  PB-LoginViewController.m
//  PANDA-BANG
//
//  Created by mhand on 15/2/15.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-LoginViewController.h"

@interface PB_LoginViewController ()

@end

@implementation PB_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ [UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    这个是登入页面的vc
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    [self.UserPhoneNameTF becomeFirstResponder];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ [UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)dissmissVC:(UIBarButtonItem *)sender {
    [self  dismissViewControllerAnimated:YES completion:nil];
    [self.UserPhoneNameTF resignFirstResponder];
    [self.PassWordTF resignFirstResponder];

}

@end
