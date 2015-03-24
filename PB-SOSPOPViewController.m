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
    UIImagePickerController *myPickerController;
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
    [self keyboardAddNSNotification];


}
//回收键盘的方法
-(void)recoverKeyBoard{

    [self.textName resignFirstResponder];
    [self.textTelephone resignFirstResponder];
    [self.textTelephoneS resignFirstResponder];


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
    [self.scrollView setContentOffset:CGPointMake(0,-64) animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initAllControl{
//    初始化一些控件
    
    [self setButton:self.sexButton];
    [self setButton:self.headButton];
    [self setButton:self.bloodButton];
//    给滚动视图添加方法 来回收键盘
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBoard)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.scrollView addGestureRecognizer:tap];


}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
// 当文字开始编辑 设置文字框上移
  [self.scrollView setContentOffset:CGPointMake(0, 250) animated:YES];
    return YES;

}
- (IBAction)nextStepAction:(UIButton *)sender {
//    点击下一步操作
    NSMutableString *errors=[NSMutableString string];
    [self recoverKeyBoard];
//    判断是否有以下错误 并且加到字符串上
    if ([self.textName.text isEqualToString:@""]) {
        [errors appendFormat:@"%@\n",@" 姓名没有填写"];
        
    }
    else if (![self.textName.text isChinese]){
        [errors appendFormat:@"%@\n",@" 填写中文姓名"];

    }
    else if ([self.textTelephone.text isEqualToString:@""]||[self.textTelephoneS.text isEqualToString:@""]){
        
        [errors appendFormat:@"%@\n",@"电话没有填写"];
        
    }

    else if ([self.textTelephone.text length]!=11||[self.textTelephoneS.text length]!=11){
    
       [errors appendFormat:@"%@\n",@"电话位数不对"];
    
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

-(void)setButton:(UIButton *)sender{
    sender.layer.cornerRadius=20;
    sender.layer.masksToBounds=YES;
    }
//选择头像按钮
- (IBAction)chooseHead:(UIButton *)sender {
    UIActionSheet *chooseHead=[[UIActionSheet alloc]initWithTitle:@"头像照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
    chooseHead.tag=33;
    [chooseHead showInView:self.view];

}
//添加头像图片按钮
-(void)addImage:(UIButton *)sender{
    
    UIActionSheet *choosePhotoType=[[UIActionSheet alloc]initWithTitle:@"获取情况照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"照片库", nil];
    [choosePhotoType showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        if (buttonIndex==0) {
//        拍照
            [self  takePhotopicker];
        }
        else if (buttonIndex==1){
            [self photoFromAlbum];
            
        }
   }
//选择性别按钮
- (IBAction)chooseSex:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"男"]) {
        [sender setTitle:@"女" forState:UIControlStateNormal];
    }
    else{
        [sender setTitle:@"男" forState:UIControlStateNormal];
        
    }

}
//选择血型按钮
- (IBAction)chooseBlood:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"A"]) {
        [sender setTitle:@"B" forState:UIControlStateNormal];
    }
    else if([sender.titleLabel.text isEqualToString:@"B"]){
        [sender setTitle:@"AB" forState:UIControlStateNormal];
        
    }
    else if([sender.titleLabel.text isEqualToString:@"AB"]){
        [sender setTitle:@"O" forState:UIControlStateNormal];
        
    }
    else if([sender.titleLabel.text isEqualToString:@"O"]){
        [sender setTitle:@"A" forState:UIControlStateNormal];
        
    }

}
//返回vc
- (IBAction)backVC:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}
//选择年龄
- (IBAction)ageChange:(UISlider *)sender {
    self.age.text=[NSString stringWithFormat:@"%.0f岁",sender.value*100];
   
}
//血量选择
- (IBAction)volumeChange:(UISlider *)sender {
    NSString *volumeN=[NSString stringWithFormat:@"%.0f",sender.value*100];
    int volumeNN=[volumeN floatValue];
    self.volume.text=[NSString stringWithFormat:@"%d毫升",volumeNN*100];

}

//创建pickerv
-(void)createMyPickerController:(UIImagePickerControllerSourceType )sourceType{
        if (myPickerController==nil) {
            
            
            myPickerController=[[UIImagePickerController alloc]init];
            
            myPickerController.delegate=self;
            //    能否允许编辑
            myPickerController.allowsEditing = YES;
            myPickerController.sourceType=sourceType;
            
        }
  
}


//拍照
-(void)takePhotopicker{
    [self createMyPickerController:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:myPickerController animated:YES completion:^{ }];
        
   }
//照片库取照片
-(void)photoFromAlbum{
    
    //    能否允许编
    [self createMyPickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    
    
    [self presentViewController:myPickerController animated:YES completion:^{ }];
    
}
//完成选取后
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
        UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
        [self getHead:image];

    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
//加入照片
-(void)getHead:(UIImage *)image{
//    防止图片渲染成蓝色
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [self.headButton setImage:image forState:UIControlStateNormal];
    
}
//取消拍摄 回收
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
//离开页面前删除通知
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
