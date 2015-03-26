//
//  PB-SOSPOPViewController.m
//  PANDA-BANG
//
//  Created by doup0580 on 15/3/23.
//  Copyright (c) 2015年 mhand. All rights reserved.
//

#import "PB-SOSPOPViewController.h"
#import "PB-SOSPOPSecondViewController.h"
#import "NSString+Valid.h"

@interface PB_SOSPOPViewController ()

@end

@implementation PB_SOSPOPViewController
{
    BOOL informationComplete;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllControl];
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
//    每次将要出现  添加键盘hide通知
    [super viewWillAppear:animated];
    [ [UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [self keyboardAddNSNotification];


}
//回收键盘的方法
-(void)recoverKeyBoard{

    [self.textName resignFirstResponder];
    [self.textAge resignFirstResponder];

}
-(void)keyboardAddNSNotification{
    //增加监听
       [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
-(void)keyboardWillHide:(NSNotification *)aNotification{
//当键盘回收 滚动视图下移

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initAllControl{


}
-(void)setButton:(UIButton *)sender{
    sender.layer.cornerRadius=20;
    sender.layer.masksToBounds=YES;
}
//返回vc
- (IBAction)backVC:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

- (IBAction)chooseBlood:(UIButton *)sender {
    UIActionSheet *bloodType=[[UIActionSheet alloc]initWithTitle:@"选择RH阴性血型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"A型血" otherButtonTitles:@"B型血" ,@"AB型血", @"O型血",nil];
    [bloodType showInView:self.view];
    
    
}

- (IBAction)chooseLocation:(UIButton *)sender {
    [self performSegueWithIdentifier:@"locationPush" sender:nil];
}

//离开页面前删除通知
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [ [UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }
    else if (buttonIndex==1){
    }
    else if (buttonIndex==2){
    }
    else if (buttonIndex==3){
    }





}



- (IBAction)nextStepAction:(UIButton *)sender {
//    点击下一步操作
    NSMutableString *errors=[NSMutableString string];
    [self recoverKeyBoard];
//    判断是否有以下错误 并且加到字符串上
    if ([self.textName.text isEqualToString:@""]) {
        [errors appendFormat:@"%@\n",@" 姓名没有填写"];
        
    }
   if (![self.textName.text isChinese]){
        [errors appendFormat:@"%@\n",@" 填写中文姓名"];

    }
    if ([self.textAge.text isEqualToString:@""]) {
        [errors appendFormat:@"%@\n",@" 年龄没有填写"];
        
    }
        // 如果没有error 推送下一页面
    if ([errors isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"nextStep" sender:nil];
        

    }
//    否则弹出警告
    else
    {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"注意" message:errors delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
        [alertView show];
    
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
